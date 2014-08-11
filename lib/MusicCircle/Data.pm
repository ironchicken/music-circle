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

use MusicCircle::Config;

package MusicCircle::Data;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(connect find_works $store);

our $store;

sub connect {
    return if (defined $store);

    # KiokuDB and RDF::Trine::Store are both available, the
    # object_store configuration option determines which should be
    # used
    if ($MusicCircle::Config::options->{store} eq 'object') {
        use KiokuDB;
        use KiokuDB::TypeMap;
        use KiokuDB::TypeMap::Entry::Callback;

        $store = KiokuDB->connect(
            $MusicCircle::Config::options->{object_store}->{dsn},
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
    elsif ($MusicCircle::Config::options->{store} eq 'rdf') {
        use RDF::Trine::Store;

        $store = RDF::Trine::Store->new($MusicCircle::Config::options->{rdf_store});
    }
}

sub find_works {
    return [];
}

1;
