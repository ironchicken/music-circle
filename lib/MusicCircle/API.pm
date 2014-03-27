#
# Transforming Musicology -- Music Circle
#
# Music Circle is a social music collaboration tool developed by
# Matthew Yee-King and colleagues on the PRAISE project at Goldsmiths'
# College, University of London. This project implements a similar
# Web-based musical commenting system, but working with existing
# musical works rather than uploaded audio performances.
#
# Authors: Richard Lewis <richard.lewis@gold.ac.uk>
#
# Copyright (C) 2013 Richard Lewis, Goldsmiths' College

package MusicCircle::API;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($mc);

use MusicCircle::Data;

use Plack::Builder;
use Plack::Request;
use Plack::Middleware::REST;
use Plack::Middleware::Negotiate;
use Plack::Middleware::Cached;
use Plack::Middleware::Options;
use Plack::Middleware::REST::Util;
use Plack::Middleware::OAuth;
use Cache::Memcached::Fast;
use JSON::Syck;

# Ensure that all the classes that the API can serve up are loaded
use Musical::Work;
use Musical::Expression;
use Musical::Manifestation;
use Musical::Item;
use MusicCircle::Contributor;
use MusicCircle::Conversation;
use MusicCircle::Assertion;

sub retrieve_object {
    my ($env, $class) = (shift, shift);

    if ($MusicCircle::Config::options->{store} eq 'rdf') {
        my $req = Plack::Request->new($env);
        my $uri = $MusicCircle::Config::options->{uri_domain} . $req->request_uri;
        my $count = $MusicCircle::Data::store->count_statements(RDF::Trine::Node::Resource->new($uri), undef, undef);

        return $class->new_from_store($uri) if $count;
    }
    elsif ($MusicCircle::Config::options->{store} eq 'object') {
        my $scope = $MusicCircle::Data::store->new_scope;
        my $id = request_id($env);
        my $obj = $MusicCircle::Data::store->lookup($id);

        return $obj if ($obj && ($obj->blessed() eq $class));
    }
}

my $retrieve_json = sub {
    my ($env, $class) = (shift, shift);
    my %args = @_;

    my $req = Plack::Request->new($env);
    my $obj = retrieve_object($env, $class);

    if ($obj) {
        return [200, [], [JSON::Syck::Dump($obj)]];

        # Ideally, we would use MooseX::Storage like this
        #return [200, [], [$obj->freeze()]];
    } else {
        return [404, [], [JSON::Syck::Dump("#$id was not found.\n")]];
    }
};

my $retrieve_rdf = sub {
    my ($env, $class) = (shift, shift);
    my %args = @_;

    my $req = Plack::Request->new($env);
    my $obj = retrieve_object($env, $class);

    if ($obj) {
        return [200, [], [$obj->export_to_string(format => $args{format} || $DEFAULT_FORMAT)]];
    } else {
        return [404, [], ["#$id was not found.\n"]];
    }
};

our $cache = Cache::Memcached::Fast->new($MusicCircle::Config::options->{memcached});

my $mc_app = sub { };

our $mc = builder {
    mount "/musical-work" => builder {
        enable 'Options', allowed => [qw(GET POST PUT DELETE)];
        enable 'REST',
        get => builder {
            #enable 'Cache', cache => $cache;
            enable 'Negotiate',
            formats => {
                xml => {
                    type => 'application/x-mc-musical-work+xml',
                    app => sub { $retrieve_xml->(shift, 'Musical::Work'); } },
                turtle => {
                    type => 'application/x-mc-musical-work+turtle',
                    app => sub { $retrieve_rdf->(shift, 'Musical::Work', format => 'turtle'); } },
                rdfxml => {
                    type => 'application/x-mc-musical-work+rdfxml',
                    app => sub { $retrieve_rdf->(shift, 'Musical::Work', format => 'rdfxml'); } },
                json => {
                    type => 'application/x-mc-musical-work+json',
                    app => sub { $retrieve_json->(shift, 'Musical::Work'); } },
                html => {
                    type => 'application/x-mc-musical-work+html',
                    app => sub { $retrieve_html->(shift, 'Musical::Work'); } },
                _ => {
                    app => $retrieve_musical_work_json },
            },
            parameter => 'format',
            extension => 'strip';
        },
        create => builder {
            #enable 'OAuth',
            #providers => $MusicCircle::Config::options->{oauth_providers},
            on_success => builder {
                enable 'Negotiate',
                formats => {
                    xml => {
                        type => 'application/x-mc-musical-work+xml',
                        app => $create_musical_work_from_xml },
                    turtle => {
                        type => 'application/x-mc-musical-work+turtle',
                        app => $create_musical_work_from_rdf },
                    json => {
                        type => 'application/x-mc-musical-work+json',
                        app => $create_musical_work_from_json },
                    musicxml => {
                        type => 'application/x-mc-musical-work+musicxml',
                        app => $create_musical_work_from_musicxml },
                    kern => {
                        type => 'application/x-mc-musical-work+kern',
                        app => $create_musical_work_from_kern },
                    _ => { size => 0 }
                },
                parameter => 'format',
                extension => 'strip';
            },
            on_error => sub { },
        },
        # upsert       => Plack::Middleware::MusicCircle::Update->new({resource => 'musical-work'}),
        # delete       => Plack::Middleware::MusicCircle::Delete->new({resource => 'musical-work'}),
        # list         => Plack::Middleware::MusicCircle::List->new({resource => 'musical-work'}),
        pass_through => 0;
        $mc_app;
    },
    mount "/musical-expression" => builder {
        enable 'Options', allowed => [qw(GET POST PUT DELETE)];
        enable 'REST',
        get => builder {
            #enable 'Cache', cache => $cache;
            enable 'Negotiate',
            formats => {
                turtle => {
                    type => 'application/x-mc-musical-expression+turtle',
                    app => sub { $retrieve_rdf->(shift, 'Musical::Expression', format => 'turtle'); } },
                rdfxml => {
                    type => 'application/x-mc-musical-expression+rdfxml',
                    app => sub { $retrieve_rdf->(shift, 'Musical::Expression', format => 'rdfxml'); } },
                _ => {
                    app => sub { $retrieve_json->(shift, 'Musical::Expression'); } },
            },
            parameter => 'format',
            extension => 'strip';
        },
        create => builder {
            #enable 'OAuth',
            #providers => $MusicCircle::Config::options->{oauth_providers},
            on_success => builder {
                enable 'Negotiate',
                formats => {
                    xml => {
                        type => 'application/x-mc-musical-expression+xml',
                        app => $create_musical_expression_from_xml },
                    turtle => {
                        type => 'application/x-mc-musical-expression+turtle',
                        app => $create_musical_expression_from_rdf },
                    json => {
                        type => 'application/x-mc-musical-expression+json',
                        app => $create_musical_expression_from_json },
                    musicxml => {
                        type => 'application/x-mc-musical-expression+musicxml',
                        app => $create_musical_expression_from_musicxml },
                    kern => {
                        type => 'application/x-mc-musical-expression+kern',
                        app => $create_musical_expression_from_kern },
                    _ => { size => 0 }
                },
                parameter => 'format',
                extension => 'strip';
            },
            on_error => sub { },
        },
        # upsert       => Plack::Middleware::MusicCircle::Update->new({resource => 'musical-expression'}),
        # delete       => Plack::Middleware::MusicCircle::Delete->new({resource => 'musical-expression'}),
        # list         => Plack::Middleware::MusicCircle::List->new({resource => 'musical-expression'}),
        pass_through => 0;
        $mc_app;
    },
    mount "/musical-manifestation" => builder {
        enable 'Options', allowed => [qw(GET POST PUT DELETE)];
        enable 'REST',
        get => builder {
            #enable 'Cache', cache => $cache;
            enable 'Negotiate',
            formats => {
                turtle => {
                    type => 'application/x-mc-musical-manifestation+turtle',
                    app => sub { $retrieve_rdf->(shift, 'Musical::Manifestation', format => 'turtle'); } },
                rdfxml => {
                    type => 'application/x-mc-musical-manifestation+rdfxml',
                    app => sub { $retrieve_rdf->(shift, 'Musical::Manifestation', format => 'rdfxml'); } },
                json => {
                    type => 'application/x-mc-musical-manifestation+json',
                    app => sub { $retrieve_json->(shift, 'Musical::Manifestation'); } },
                musicxml => {
                    type => 'application/x-mc-musical-manifestation+musicxml',
                    app => sub { $retrieve_musicxml->(shift, 'Musical::Manifestation'); } },
                kern => {
                    type => 'application/x-mc-musical-manifestation+kern',
                    app => sub { $retrieve_kern->(shift, 'Musical::Manifestation'); } },
                mp3 => {
                    type => 'application/x-mc-musical-manifestation+mp3',
                    app => sub { $retrieve_mp3->(shift, 'Musical::Manifestation'); } },
                _ => {
                    app => sub { $retrieve_json->(shift, 'Musical::Manifestation'); } },
            },
            parameter => 'format',
            extension => 'strip';
        },
        create => builder {
            #enable 'OAuth',
            #providers => $MusicCircle::Config::options->{oauth_providers},
            on_success => builder {
                enable 'Negotiate',
                formats => {
                    xml => {
                        type => 'application/x-mc-musical-manifestation+xml',
                        app => $create_musical_manifestation_from_xml },
                    turtle => {
                        type => 'application/x-mc-musical-manifestation+turtle',
                        app => $create_musical_manifestation_from_rdf },
                    json => {
                        type => 'application/x-mc-musical-manifestation+json',
                        app => $create_musical_manifestation_from_json },
                    musicxml => {
                        type => 'application/x-mc-musical-manifestation+musicxml',
                        app => $create_musical_manifestation_from_musicxml },
                    kern => {
                        type => 'application/x-mc-musical-manifestation+kern',
                        app => $create_musical_manifestation_from_kern },
                    _ => { size => 0 }
                },
                parameter => 'format',
                extension => 'strip';
            },
            on_error => sub { },
        },
        # upsert       => Plack::Middleware::MusicCircle::Update->new({resource => 'musical-manifestation'}),
        # delete       => Plack::Middleware::MusicCircle::Delete->new({resource => 'musical-manifestation'}),
        # list         => Plack::Middleware::MusicCircle::List->new({resource => 'musical-manifestation'}),
        pass_through => 0;
        $mc_app;
    },
};

1;
