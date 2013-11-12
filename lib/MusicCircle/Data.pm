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

use KiokuDB;
use MusicCircle::Config;

package MusicCircle::Data;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(connect);

our $d;

sub connect {
    $d = KiokuDB->connect($MusicCircle::Config::options->{DSN}, create => 1);
}

1;
