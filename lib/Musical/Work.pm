#
# Transforming Musicology -- Music Circle
#
# Music Circle is a social music discussion tool. It provides a
# hypermedia API for indentifying musical works and their
# manifestations, and for capturing discussion about those works.
# 
# The original Music Circle concept and implementation was developed by
# Matthew Yee-King and colleagues on the PRAISE project at Goldsmiths'
# College, University of London.
#
# Authors: Richard Lewis <richard.lewis@gold.ac.uk>
#
# Copyright (C) 2013, 2014 Richard Lewis, Goldsmiths' College

use MusicCircle::Config;

package Musical::Work;

use MusicCircle::ExternalData;
use MusicCircle::Resource;

# This package defines the Musical::Work class which corresponds with
# the Music Ontology class mo:MusicalWork.

use Moose;
use MooseX::ClassAttribute;
use namespace::autoclean;

with ('MooseX::Semantic::Role::RdfImport', 'MooseX::Semantic::Role::RdfExport', 'MooseX::Semantic::Role::RdfBackend', 'StagedConstruction' => { stages => ['DeserializeWork', 'UseExistingWork'] });

use RDF::Trine::Namespace qw(rdf xsd);
use Musical qw($mo);
use MusicCircle qw($mc $auto_rdf_about);
use FRBR qw($frbr $dc);

__PACKAGE__->rdf_type($mo->MusicalWork);
__PACKAGE__->rdf_store($MusicCircle::Config::options->{rdf_store})
    if ($MusicCircle::Config::options->{store} eq 'rdf');

class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'prs.t-mus.mc-musical-work',
    );

class_has 'uri_namespace' => (
    is           => 'ro',
    isa          => 'Str',
    default      => '/musical-work',
    );

around BUILDARGS => $auto_rdf_about;

has 'id' => (
    traits       => ['Semantic'],
    is           => 'ro',
    isa          => 'Str',
    uri          => $mc->id,
    rdf_datatype => $xsd->string,
    );

has 'title' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Str',
    uri          => $dc->title,
    rdf_datatype => $xsd->string,
    );

has 'creator' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'FRBR::ResponsibleEntity',
    uri          => $frbr->creator,
    );

has 'iswc' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Str',
    uri          => $mo->iswc,
    rdf_datatype => $xsd->string,
    );

has 'composed_in' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Musical::Composition',
    uri          => $mo->composed_in,
    );

has 'arranged_in' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Musical::Arrangement',
    uri          => $mo->arranged_in,
    );

has 'opus' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Str',
    uri          => $mo->opus,
    rdf_datatype => $xsd->string,
    );

has 'lyrics' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Musical::Lyrics',
    uri          => $mo->lyrics,
    );

sub BUILD {
    my $self = shift;
    my $args = shift;

    return $self->do_staged_build($args);
}


__PACKAGE__->meta->make_immutable;

package DeserializeWork;

# This object construction stage allows objects to be parsed from
# various serialisation formats.

use Moose;
use namespace::autoclean;
use JSON;

extends 'ConstructionStage';

sub init_stage {
    my $self = shift;
    my $obj = shift;
    my $args = shift;

    return $args unless (defined $args->{from_content_type} && defined $args->{content});

    # parse the supplied data into a work hash
    my $work_meta;
    eval {
        if ($args->{from_content_type} =~ /\+json$/) {
            $work_meta = parse_json($args->{content});
        } elsif ($args->{from_content_type} =~ /\+turtle$/) {
            $work_meta = parse_turtle($args->{content});
        } elsif ($args->{from_content_type} =~ /\+xml$/) {
            $work_meta = parse_xml($args->{content});
        }
    };
    if ($@) {
        die "Failed to parse content: $@";
    }

    $args->{work_meta} = $work_meta;

    return $args
}

sub parse_json {
    return decode_json shift;
}

sub parse_turtle {

}

sub parse_xml {

}

sub do_stage {
    my $self = shift;
    my $obj = shift;
    my $args = shift;

    return $self unless (defined $args->{work_meta});

    # copy all the work_meta properties to $self
    while (my ($k, $v) = each %{ $args->{work_meta} }) {
        $obj->{$k} = $v;
    }

    return $obj;
}

package UseExistingWork;

# This object construction stage implements a disambiguation
# construction workflow making use of external authorities on musical
# works to attempt to uniquely identify the musical work the client is
# attempting to create.

use Moose;
use namespace::autoclean;

extends 'ConstructionStage';
with 'OptionStage';

sub options {
    my $self = shift;
    my $obj = shift;
    my $args = shift;

    return {} unless (defined $args->{work_meta});

    # lookup the work hash in the Music Circle database
    my $local_works = MusicCircle::Data::find_works($args->{work_meta});

    # lookup the work hash in the external sources
    my $remote_works = MusicCircle::ExternalData::find_works($args->{work_meta});

    $args->{_options} = {'local' => $local_works, 'remote' => $remote_works};

    return $args;
}

sub select {
    # FIXME Implement selection, possibly as HTTP 300 Multiple Choices
}

1;
