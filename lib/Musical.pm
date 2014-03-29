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

package Musical;

# This package defines and exports some XML namespaces used for the
# RDF types in Musical data models.

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($mo);

use RDF::Trine::Namespace ();
our $mo = RDF::Trine::Namespace->new('http://purl.org/ontology/mo#');

1;
