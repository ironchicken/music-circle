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
__PACKAGE__->rdf_store($MusicCircle::Config::options->{rdf_store})
    if ($MusicCircle::Config::options->{store} eq 'rdf');

class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'prs.t-mus.mc-contributor',
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
