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

package MusicCircle;

# This package defines and exports some XML namespaces used for the
# RDF types in MusicCircle data mcdels.

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($mc $auto_rdf_about);

use MusicCircle::Config;

use RDF::Trine::Namespace ();
our $mc = RDF::Trine::Namespace->new('http://musiccircle.t-mus.org/terms#');

use UUID::Tiny qw(create_uuid_as_string);

our $auto_rdf_about  = sub {
    my $orig  = shift;
    my $class = shift;
    my %args  = @_;

    my $uri_prefix = $MusicCircle::Config::options->{uri_domain} . $class->uri_namespace;

    if (defined $args{rdf_about}) {
        $args{id} = $args{rdf_about} =~ s|$uri_prefix/||r;
    } else {
        my $id = create_uuid_as_string();
        $args{id} = $id;
        $args{rdf_about} = $uri_prefix . "/" . $id;
    }

    return $class->$orig(%args);
};

1;
