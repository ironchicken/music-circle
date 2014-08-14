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

package Musical::Manifestation {

    # This package defines the Musical::Manifestation class which
    # corresponds with the Music Ontology class
    # mo:MusicalManifestation.

    use Moose;
    use MooseX::ClassAttribute;
    use namespace::autoclean;

    with ('MooseX::Semantic::Role::RdfImport',
          'MooseX::Semantic::Role::RdfExport',
          'MooseX::Semantic::Role::RdfBackend');

    use RDF::Trine::Namespace qw(rdf xsd);
    use Musical qw($mo);
    use MusicCircle qw($mc $auto_rdf_about);
    use FRBR qw($frbr);
    use FOAF;
    use MusicCircle::MediaType;
    use Musical::Expression;

    __PACKAGE__->rdf_type($mo->MusicalManifestation);
    __PACKAGE__->rdf_store($MusicCircle::Config::options->{rdf_store})
        if ($MusicCircle::Config::options->{store} eq 'rdf');

    class_has 'media_type' => (
        is           => 'ro',
        isa          => 'Str',
        default      => 'prs.t-mus.mc-musical-manifestation',
        );

    class_has 'uri_namespace' => (
        is           => 'ro',
        isa          => 'Str',
        default      => '/musical-manifestation',
        );

    around BUILDARGS => $auto_rdf_about;

    has 'id' => (
        traits       => ['Semantic'],
        is           => 'ro',
        isa          => 'Str',
        uri          => $mc->id,
        rdf_datatype => $xsd->string,
        );

    has 'embodiment_of' => (
        traits       => ['Semantic'],
        is           => 'rw',
        isa          => 'Musical::Expression',
        uri          => $frbr->embodiment_of,
        );

    has 'alternate' => (
        traits       => ['Semantic'],
        is           => 'rw',
        isa          => 'Musical::Manifestation',
        uri          => $frbr->alternate,
        );

    has 'alternate_of' => (
        traits       => ['Semantic'],
        is           => 'rw',
        isa          => 'Musical::Manifestation',
        uri          => $frbr->alternate_of,
        );

    has 'compilation_of' => (
        traits       => ['Semantic'],
        is           => 'rw',
        isa          => 'ArrayRef[Musical::Signal]',
        uri          => $mo->compilation_of,
        );

    has 'compiler' => (
        traits       => ['Semantic'],
        is           => 'rw',
        isa          => 'FOAF::Agent',
        uri          => $mo->compiler,
        );

    has 'content_type' => (
        traits       => ['Semantic'],
        is           => 'rw',
        isa          => 'MusicCircle::MediaType',
        uri          => $mo->media_type,
        );

    has 'other_release_of' => (
        traits       => ['Semantic'],
        is           => 'rw',
        isa          => 'Musical::Manifestation',
        uri          => $mo->other_release_of,
        );

    has 'preview' => (
        traits       => ['Semantic'],
        is           => 'rw',
        isa          => 'Musical::Item',
        uri          => $mo->preview,
        );

    has 'producer' => (
        traits       => ['Semantic'],
        is           => 'rw',
        isa          => 'FOAF::Agent',
        uri          => $mo->producer,
        );

    has 'publication_of' => (
        traits       => ['Semantic'],
        is           => 'rw',
        isa          => 'Musical::Expression',
        uri          => $mo->publication_of,
        );

    has 'publisher' => (
        traits       => ['Semantic'],
        is           => 'rw',
        isa          => 'FOAF::Agent',
        uri          => $mo->publisher,
        );

    has 'publishing_location' => (
        traits       => ['Semantic'],
        is           => 'rw',
        isa          => 'Str',
        uri          => $mo->publishing_location,
        rdf_datatype => $xsd->string,
        );

    has 'release_status' => (
        traits       => ['Semantic'],
        is           => 'rw',
        isa          => 'Str',
        uri          => $mo->release_status,
        rdf_datatype => $xsd->string,
        );

    has 'release_type' => (
        traits       => ['Semantic'],
        is           => 'rw',
        isa          => 'Str',
        uri          => $mo->release_type,
        rdf_datatype => $xsd->string,
        );

    __PACKAGE__->meta->make_immutable;
}

1;
