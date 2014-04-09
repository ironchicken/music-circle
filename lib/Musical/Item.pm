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

package Musical::Item;

# This package defines the Musical::Item class which corresponds
# with the Music Ontology class mo:MusicalItem.

use Moose;
use MooseX::ClassAttribute;
use namespace::autoclean;

with 'MooseX::Semantic::Role::RdfImport', 'MooseX::Semantic::Role::RdfExport', 'MooseX::Semantic::Role::RdfBackend';

use RDF::Trine::Namespace qw(rdf xsd);
use Musical qw($mo);
use MusicCircle qw($mc $auto_rdf_about);
use FRBR;
use Musical::Manifestation;

__PACKAGE__->rdf_type($mo->MusicalItem);

class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'prs.t-mus.mc-musical-item',
    );

class_has 'uri_namespace' => (
    is           => 'ro',
    isa          => 'Str',
    default      => '/musical-item',
    );

around BUILDARGS => $auto_rdf_about;

has 'id' => (
    traits       => ['Semantic'],
    is           => 'ro',
    isa          => 'Str',
    uri          => $mc->id,
    rdf_datatype => $xsd->string,
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
