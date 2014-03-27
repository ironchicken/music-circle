#!/usr/bin/perl

use strict;
use warnings;

use lib '../lib';

use MusicCircle::Config 'test-config.yaml';
require MusicCircle::Data;

my $scope;
if ($MusicCircle::Config::options->{store} eq 'object') {
    MusicCircle::Data::connect();
    $scope = $MusicCircle::Data::store->new_scope;
}

# This test just tries creating and storing an object of each class in
# MusicCircle.

require FOAF;
require Musical::Work;
require Musical::Expression;
require Musical::Manifestation;
require Musical::Item;

# construct some objects

my @objects = ();

my $work = Musical::Work->new(title => 'Symphony No. 5');
push @objects, [Musical::Work->media_type, $work];

my $expr = Musical::Expression->new(realization_of => $work);
push @objects, [Musical::Expression->media_type, $expr];

my $manif = Musical::Manifestation->new(embodiment_of => $expr);
push @objects, [Musical::Manifestation->media_type, $manif];

my $item = Musical::Item->new(exemplar_of => $manif);
push @objects, [Musical::Item->media_type, $item];

push @objects, [FOAF::Agent->media_type, FOAF::Agent->new(name => 'Test Agent')];

# store those objects

foreach my $s (@objects) {
    my ($mtype, $obj) = @$s;
    print "$mtype ID: " . $obj->id . "\n";
    print "$mtype URI: " . $obj->rdf_about . "\n";
    print $obj->export_to_string(format => 'turtle');
    print "\n";
    eval {
        if ($MusicCircle::Config::options->{store} eq 'rdf') {
            print "Storing: . " . $obj->store() . "\n";
            print "$mtype $obj stored as " . $obj->id . "\n";
        }
        elsif ($MusicCircle::Config::options->{store} eq 'object') {
            my $obj_id = $MusicCircle::Data::store->store($obj->id => $obj);
            print "$mtype $obj stored as $obj_id\n";
        }
    };
    warn "$@\n" if ($@);
    print "\n";
}

