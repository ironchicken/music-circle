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

use strict;
use warnings;
use YAML::Tiny;

package MusicCircle::Config;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(load_config);

our $options;
my $config_file;

sub import {
    my ($package, $file) = @_;

    return unless defined $file && -e $file;

    unless (defined $config_file) { $config_file = $file; }
    unless (defined $options) { load_config(); }
}

sub load_config {
    my $file = shift;
    $config_file = $file if (defined $file && -e $file);

    my $yaml = YAML::Tiny->read($config_file) || die "Could not load config: " . YAML::Tiny->errstr . "\n";
    $options = $yaml->[0];
}

1;
