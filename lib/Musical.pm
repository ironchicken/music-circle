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

package Musical;

# This package defines and exports some XML namespaces used for the
# RDF types in Musical data models.

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($mo $frbr);

use RDF::Trine::Namespace ();
our $mo = RDF::Trine::Namespace->new('http://purl.org/ontology/mo#');
our $frbr = RDF::Trine::Namespace->new('http://purl.org/vocab/frbr/core#');

1;
