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

package Musical::Arrangement;

# This package defines the Musical::Arrangement class which corresponds with
# the Music Ontology class mo:Arrangement.

use Moose;
use namespace::autoclean;

with qw(MooseX::Semantic::Role::PortableResource);

use RDF::Trine::Namespace qw(rdf xsd);
use Musical qw($mo);

__PACKAGE__->rdf_type($mo->Arrangement);

__PACKAGE__->meta->make_immutable;

1;
