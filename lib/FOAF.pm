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

package FOAF;

# This package provides some useful FOAF classes from
# <http://xmlns.com/foaf/spec/>

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($foaf);

use RDF::Trine::Namespace ();
our $foaf = RDF::Trine::Namespace->new('http://xmlns.com/foaf/spec/#term_');

{
package FOAF::Agent;

use Moose;
use MooseX::ClassAttribute;
use namespace::autoclean;
with qw(MooseX::Semantic::Role::PortableResource);

use RDF::Trine::Namespace qw(rdf xsd);
use MusicCircle qw($mc $auto_rdf_about);
use UUID::Tiny qw(create_uuid_as_string);

__PACKAGE__->rdf_type($foaf->Agent);

class_has 'media_type' => (
    is => 'ro',
    isa => 'Str',
    default => 'application/x-foaf-agent',
    );

class_has 'uri_namespace' => (
    is           => 'ro',
    isa          => 'Str',
    default      => '/agent',
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
}

1;
