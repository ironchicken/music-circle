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

package Musical::Work;

# This package defines the Musical::Work class which corresponds with
# the Music Ontology class mo:MusicalWork.

use Moose;
use MooseX::Storage;
use MooseX::ClassAttribute;
use namespace::autoclean;

with 'MooseX::Semantic::Role::PortableResource',
    Storage('format' => 'JSON');

use RDF::Trine::Namespace qw(rdf xsd);
use Musical qw($mo);
use MusicCircle qw($mc $auto_rdf_about);
use FRBR qw($frbr $dc);

__PACKAGE__->rdf_type($mo->MusicalWork);

class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'application/x-mc-musical-work',
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

has '+_user_agent' => (
    traits => ['DoNotSerialize'],
    );

# has '+rdf_about' => (
#     traits => ['DoNotSerialize'],
#     );

# has '+_is_auto_generated' => (
#     traits => ['DoNotSerialize'],
#     );

__PACKAGE__->meta->make_immutable;

1;
