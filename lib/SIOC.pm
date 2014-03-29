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

package SIOC;

# This package provides some useful SIOC classes from
# <http://rdfs.org/sioc/ns#>

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($sioc);

use RDF::Trine::Namespace ();
our $sioc = RDF::Trine::Namespace->new('http://rdfs.org/sioc/ns#');

1;
