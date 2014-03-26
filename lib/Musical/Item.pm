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

package Musical::Item;

# This package defines the Musical::Item class which corresponds
# with the Music Ontology class mo:MusicalItem.

use Moose;
use MooseX::ClassAttribute;
use namespace::autoclean;

with 'MooseX::Semantic::Role::RdfImport', 'MooseX::Semantic::Role::RdfExport', 'MooseX::Semantic::Role::RdfBackend';

use RDF::Trine::Namespace qw(rdf xsd);
use Musical qw($mo);
use FRBR;
use Musical::Manifestation;

__PACKAGE__->rdf_type($mo->MusicalItem);

class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'application/x-mc-musical-item',
    );

has 'exemplar_of' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Musical::Manifestation',
    uri          => $frbr->exemplar_of,
    );

has 'reconfiguration' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Musical::Item',
    uri          => $frbr->reconfiguration,
    );

has 'reconfiguration_of' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Musical::Item',
    uri          => $frbr->reconfiguration_of,
    );

has 'owner' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'FRBR::ResponsibleEntity',
    uri          => $frbr->owner,
    );

has 'encodes' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Musical::Signal',
    uri          => $mo->encodes,
    );

__PACKAGE__->meta->make_immutable;

1;
