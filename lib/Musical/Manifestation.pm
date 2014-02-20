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

package Musical::Manifestation;

use Moose;
use MooseX::ClassAttribute;
use namespace::autoclean;

with qw(MooseX::Semantic::Role::PortableResource);

use RDF::Trine::Namespace qw(rdf xsd);
use Musical qw($mo);
use FRBR qw($frbr);
use FOAF;
use MusicCircle::MediaType;
use Musical::Expression;

__PACKAGE__->rdf_type($mo->MusicalManifestation);

class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'application/x-mc-musical-manifestation',
    );

has 'embodiment_of' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Musical::Expression',
    uri          => $frbr->embodiment_of,
    );

has 'alternate' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Musical::Manifestation',
    uri          => $frbr->alternate,
    );

has 'alternate_of' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Musical::Manifestation',
    uri          => $frbr->alternate_of,
    );

has 'compilation_of' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'ArrayRef[Musical::Signal]',
    uri          => $mo->compilation_of,
    );

has 'compiler' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'FOAF::Agent',
    uri          => $mo->compiler,
    );

has 'media_type' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'MusicCircle::MediaType',
    uri          => $mo->media_type,
    );

has 'other_release_of' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Musical::Manifestation',
    uri          => $mo->other_release_of,
    );

has 'preview' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Musical::Item',
    uri          => $mo->preview,
    );

has 'producer' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'FOAF::Agent',
    uri          => $mo->producer,
    );

has 'publication_of' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Musical::Expression',
    uri          => $mo->publication_of,
    );

has 'publisher' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'FOAF::Agent',
    uri          => $mo->publisher,
    );

has 'publishing_location' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Str',
    uri          => $mo->publishing_location,
    rdf_datatype => $xsd->string,
    );

has 'release_status' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Str',
    uri          => $mo->release_status,
    rdf_datatype => $xsd->string,
    );

has 'release_type' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Str',
    uri          => $mo->release_type,
    rdf_datatype => $xsd->string,
    );

__PACKAGE__->meta->make_immutable;

1;
