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

package FRBR;

# This package provides some useful FRBR classes from
# <http://vocab.org/frbr/core>

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($frbr $dc);

use RDF::Trine::Namespace ();
our $frbr = RDF::Trine::Namespace->new('http://purl.org/vocab/frbr/core#');
our $dc = RDF::Trine::Namespace->new('http://purl.org/dc/elements/1.1/');

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
