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

package Musical::Expression;

# This package defines the Musical::Expression class which corresponds
# with the Music Ontology class mo:MusicalExpression.

use Moose;
use namespace::autoclean;

with qw(MooseX::Semantic::Role::WithRdfType');
with qw(MooseX::Semantic::Meta::Attribute::Trait);

use RDF::Trine::Namespace qw(rdf xsd);
use Musical qw($mo);
use FRBR;

__PACKAGE__->rdf_type($mo->MusicalExpression);

has 'realization_of' => (
    traits => ['Semantic'],
    is => 'rw',
    isa => 'Musical::Work',
    uri => $frbr->realization_of,
    );

has 'abridgement_of' => (
    traits => ['Semantic'],
    is => 'rw',
    isa => 'Musical::Expression',
    uri => $frbr->abridgement_of,
    );

has 'revision_of' => (
    traits => ['Semantic'],
    is => 'rw',
    isa => 'Musical::Expression',
    uri => $frbr->revision_of,
    );

has 'translation_of' => (
    traits => ['Semantic'],
    is => 'rw',
    isa => 'Musical::Expression',
    uri => $frbr->translation_of,
    );

has 'arrangement_of' => (
    traits => ['Semantic'],
    is => 'rw',
    isa => 'Musical::Expression',
    uri => $frbr->arrangement_of,
    );

has 'realizer' => (
    traits => ['Semantic'],
    is => 'rw',
    isa => 'FRBR::ResponsibleEntity',
    uri => $frbr->realizer,
    );

has 'dimensions' => (
    is => 'rw',
    isa => 'ArrayRef[Musical::Dimension]',
    );

__PACKAGE__->meta->make_immutable;

1;
