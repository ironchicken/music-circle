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

package FRBR;

# This package provides some useful FRBR classes from
# <http://vocab.org/frbr/core>

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($frbr);

use RDF::Trine::Namespace ();
our $frbr = RDF::Trine::Namespace->new('http://purl.org/vocab/frbr/core#');

{
package FRBR::ResponsibleEntity;

use Moose;
use namespace::autoclean;
with qw(MooseX::Semantic::Role::WithRdfType);

__PACKAGE__->rdf_type($frbr->ResponsibleEntity);

__PACKAGE__->meta->make_immutable;
}

{
package FRBR::Person;

use Moose;
use namespace::autoclean;
with qw(MooseX::Semantic::Role::WithRdfType);

__PACKAGE__->rdf_type($frbr->Person);

__PACKAGE__->meta->make_immutable;
}

1;
