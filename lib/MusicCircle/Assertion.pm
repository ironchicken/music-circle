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

package MusicCircle::Assertion;

# This package defines the MusicCircle::Assertion class which
# represents an assertion in a musical discourse.

use Moose;
use namespace::autoclean;

with qw(MooseX::Semantic::Role::PortableResource);

use RDF::Trine::Namespace qw(rdf xsd);
use MusicCircle qw($mc);
use SIOC qw($sioc);

__PACKAGE__->rdf_type($mc->Assertion);


__PACKAGE__->meta->make_immutable;

1;
