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

package FOAF;

# This package provides some useful FOAF classes from
# <http://xmlns.com/foaf/spec/>

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw($foaf);

use RDF::Trine::Namespace ();
our $foaf = RDF::Trine::Namespace->new('http://xmlns.com/foaf/spec/#term_');

package FOAF::Agent {

    use Moose;
    use MooseX::ClassAttribute;
    use namespace::autoclean;

    with ('MooseX::Semantic::Role::RdfImport',
          'MooseX::Semantic::Role::RdfExport',
          'MooseX::Semantic::Role::RdfBackend');

    use RDF::Trine::Namespace qw(rdf xsd);
    use SIOC;
    use MusicCircle qw($mc $auto_rdf_about);

    __PACKAGE__->rdf_type($foaf->Agent);
    __PACKAGE__->rdf_store($MusicCircle::Config::options->{rdf_store})
        if ($MusicCircle::Config::options->{store} eq 'rdf');

    class_has 'media_type' => (
        is => 'ro',
        isa => 'Str',
        default => 'prs.t-mus.foaf-agent',
        );

    class_has 'uri_namespace' => (
        is           => 'ro',
        isa          => 'Str',
        default      => '/agent',
        );

    around BUILDARGS => $auto_rdf_about;

    has 'id' => (
        traits       => ['Semantic'],
        is           => 'ro',
        isa          => 'Str',
        uri          => $mc->id,
        rdf_datatype => $xsd->string,
        );

    has 'name' => (
        traits => ['Semantic'],
        is => 'rw',
        isa => 'Str',
        uri => $foaf->name,
        rdf_datatype => $xsd->string,
        );

    has 'account' => (
        traits => ['Semantic'],
        is => 'rw',
        isa => 'SIOC::UserAccount',
        uri => $foaf->account,
        );

    __PACKAGE__->meta->make_immutable;
}

1;
