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

use MusicCircle::Config;

package MusicCircle::Data;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(connect $dir);

use KiokuDB;
use KiokuDB::TypeMap;
use KiokuDB::TypeMap::Entry::Callback;

# FIXME Find a way to make this break in a sensible way when connect()
# has not yet been called. Currently you just get "Can't call method
# "store" on an undefined value".
our $dir;

sub connect {
    $dir = KiokuDB->connect(
        $MusicCircle::Config::options->{DSN},
        create  => 1,
        typemap => KiokuDB::TypeMap->new(
            entries => {
                'RDF::Trine::Node::Resource' => KiokuDB::TypeMap::Entry::Callback->new(
                    intrinsic => 1,
                    collapse  => "uri_value",
                    expand    => "new",
                    ),
            }),
        );
}

1;
