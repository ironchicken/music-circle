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
use MooseX::ClassAttribute;
use namespace::autoclean;
with qw(MooseX::Semantic::Role::PortableResource);

use RDF::Trine::Namespace qw(rdf xsd);
use Musical qw($mo);
use FRBR qw($frbr);

__PACKAGE__->rdf_type($mo->MusicalWork);

class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'application/x-mc-musical-work',
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

__PACKAGE__->meta->make_immutable;

1;
