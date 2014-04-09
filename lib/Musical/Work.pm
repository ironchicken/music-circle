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

# This package defines the Musical::Work class which corresponds with
# the Music Ontology class mo:MusicalWork.

use Moose;
use MooseX::ClassAttribute;
use namespace::autoclean;

with 'MooseX::Semantic::Role::RdfImport', 'MooseX::Semantic::Role::RdfExport', 'MooseX::Semantic::Role::RdfBackend';

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

__PACKAGE__->meta->make_immutable;

1;
