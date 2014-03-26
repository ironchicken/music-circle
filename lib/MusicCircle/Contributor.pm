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

use FRBR qw($frbr);

package MusicCircle::Contributor;

# This package defines the MusicCircle::Contributor class which
# represents an agent who participates in a musical discourse.

use Moose;
use MooseX::ClassAttribute;

extends 'FOAF::Agent';

use namespace::autoclean;

with 'MooseX::Semantic::Role::RdfImport', 'MooseX::Semantic::Role::RdfExport', 'MooseX::Semantic::Role::RdfBackend';

use RDF::Trine::Namespace qw(rdf xsd);
use MusicCircle qw($mc $auto_rdf_about);
use SIOC qw($sioc);

__PACKAGE__->rdf_type($mc->Contributor);
__PACKAGE__->rdf_store($MusicCircle::Config::options->{rdf_store});

class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'application/x-mc-contributor',
    );

class_has 'uri_namespace' => (
    is           => 'ro',
    isa          => 'Str',
    default      => '/contributor',
    );

around BUILDARGS => $auto_rdf_about;

has 'id' => (
    traits       => ['Semantic'],
    is           => 'ro',
    isa          => 'Str',
    uri          => $mc->id,
    rdf_datatype => $xsd->string,
    );


__PACKAGE__->meta->make_immutable;

1;
