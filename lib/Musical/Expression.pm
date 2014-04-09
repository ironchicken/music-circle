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

{
package Musical::Expression;

# This package defines the Musical::Expression class which corresponds
# with the Music Ontology class mo:MusicalExpression.

use Moose;
use MooseX::ClassAttribute;
use namespace::autoclean;

with 'MooseX::Semantic::Role::RdfImport', 'MooseX::Semantic::Role::RdfExport', 'MooseX::Semantic::Role::RdfBackend';

use RDF::Trine::Namespace qw(rdf xsd);
use Musical qw($mo);
use MusicCircle qw($mc $auto_rdf_about);
use FRBR;

__PACKAGE__->rdf_type($mo->MusicalExpression);
__PACKAGE__->rdf_store($MusicCircle::Config::options->{rdf_store})
    if ($MusicCircle::Config::options->{store} eq 'rdf');

class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'prs.t-mus.mc-musical-expression',
    );

class_has 'uri_namespace' => (
    is           => 'ro',
    isa          => 'Str',
    default      => '/musical-expression',
    );

around BUILDARGS => $auto_rdf_about;

has 'id' => (
    traits       => ['Semantic'],
    is           => 'ro',
    isa          => 'Str',
    uri          => $mc->id,
    rdf_datatype => $xsd->string,
    );

has 'realization_of' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Musical::Work',
    uri          => $frbr->realization_of,
    );

has 'abridgement_of' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Musical::Expression',
    uri          => $frbr->abridgement_of,
    );

has 'revision_of' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Musical::Expression',
    uri          => $frbr->revision_of,
    );

has 'translation_of' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Musical::Expression',
    uri          => $frbr->translation_of,
    );

has 'arrangement_of' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'Musical::Expression',
    uri          => $frbr->arrangement_of,
    );

has 'realizer' => (
    traits       => ['Semantic'],
    is           => 'rw',
    isa          => 'FRBR::ResponsibleEntity',
    uri          => $frbr->realizer,
    );

has 'dimensions' => (
    is           => 'rw',
    isa          => 'ArrayRef[Musical::Dimension]',
    );

sub render {

}

sub select_point {

}

sub select_region {

}

sub search {

}

sub browse {

}

sub sonify {

}

__PACKAGE__->meta->make_immutable;
}

{
package Musical::Libretto;

use Moose;
use MooseX::ClassAttribute;
use namespace::autoclean;

with 'MooseX::Semantic::Role::RdfImport', 'MooseX::Semantic::Role::RdfExport', 'MooseX::Semantic::Role::RdfBackend';

extends 'Musical::Expression';

use RDF::Trine::Namespace qw(rdf xsd);
use Musical qw($mo);
use MusicCircle qw($mc $auto_rdf_about);

__PACKAGE__->rdf_type($mo->Libretto);
__PACKAGE__->rdf_store($MusicCircle::Config::options->{rdf_store})
    if ($MusicCircle::Config::options->{store} eq 'rdf');

class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'prs.t-mus.mc-libretto',
    );

class_has 'uri_namespace' => (
    is           => 'ro',
    isa          => 'Str',
    default      => '/libretto',
    );

around BUILDARGS => $auto_rdf_about;

has 'id' => (
    traits       => ['Semantic'],
    is           => 'ro',
    isa          => 'Str',
    uri          => $mc->id,
    rdf_datatype => $xsd->string,
    );


__PACKAGE__->meta->make_immutable;
}

{
package Musical::Lyrics;

use Moose;
use MooseX::ClassAttribute;
use namespace::autoclean;

with 'MooseX::Semantic::Role::RdfImport', 'MooseX::Semantic::Role::RdfExport', 'MooseX::Semantic::Role::RdfBackend';

extends 'Musical::Expression';

use RDF::Trine::Namespace qw(rdf xsd);
use Musical qw($mo);
use MusicCircle qw($mc $auto_rdf_about);

__PACKAGE__->rdf_type($mo->Lyrics);
__PACKAGE__->rdf_store($MusicCircle::Config::options->{rdf_store})
    if ($MusicCircle::Config::options->{store} eq 'rdf');

class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'prs.t-mus.mc-lyrics',
    );

class_has 'uri_namespace' => (
    is           => 'ro',
    isa          => 'Str',
    default      => '/lyrics',
    );

around BUILDARGS => $auto_rdf_about;

has 'id' => (
    traits       => ['Semantic'],
    is           => 'ro',
    isa          => 'Str',
    uri          => $mc->id,
    rdf_datatype => $xsd->string,
    );


__PACKAGE__->meta->make_immutable;
}

{
package Musical::Score;

use Moose;
use MooseX::ClassAttribute;
use namespace::autoclean;

with 'MooseX::Semantic::Role::RdfImport', 'MooseX::Semantic::Role::RdfExport', 'MooseX::Semantic::Role::RdfBackend';

extends 'Musical::Expression';

use RDF::Trine::Namespace qw(rdf xsd);
use Musical qw($mo);
use MusicCircle qw($mc $auto_rdf_about);

__PACKAGE__->rdf_type($mo->Score);

class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'prs.t-mus.mc-score',
    );

class_has 'uri_namespace' => (
    is           => 'ro',
    isa          => 'Str',
    default      => '/score',
    );

around BUILDARGS => $auto_rdf_about;

has 'id' => (
    traits       => ['Semantic'],
    is           => 'ro',
    isa          => 'Str',
    uri          => $mc->id,
    rdf_datatype => $xsd->string,
    );

__PACKAGE__->meta->make_immutable;
}

{
package Musical::Signal;

use Moose;
use MooseX::ClassAttribute;
use namespace::autoclean;

with 'MooseX::Semantic::Role::RdfImport', 'MooseX::Semantic::Role::RdfExport', 'MooseX::Semantic::Role::RdfBackend';

extends 'Musical::Expression';

use RDF::Trine::Namespace qw(rdf xsd);
use Musical qw($mo);
use MusicCircle qw($mc $auto_rdf_about);

__PACKAGE__->rdf_type($mo->Signal);
__PACKAGE__->rdf_store($MusicCircle::Config::options->{rdf_store})
    if ($MusicCircle::Config::options->{store} eq 'rdf');

class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'prs.t-mus.mc-signal',
    );

class_has 'uri_namespace' => (
    is           => 'ro',
    isa          => 'Str',
    default      => '/signal',
    );

around BUILDARGS => $auto_rdf_about;

has 'id' => (
    traits       => ['Semantic'],
    is           => 'ro',
    isa          => 'Str',
    uri          => $mc->id,
    rdf_datatype => $xsd->string,
    );


__PACKAGE__->meta->make_immutable;
}

{
package Musical::SignalGroup;

use Moose;
use MooseX::ClassAttribute;
use namespace::autoclean;

with 'MooseX::Semantic::Role::RdfImport', 'MooseX::Semantic::Role::RdfExport', 'MooseX::Semantic::Role::RdfBackend';

extends 'Musical::Expression';

use RDF::Trine::Namespace qw(rdf xsd);
use Musical qw($mo);
use MusicCircle qw($mc $auto_rdf_about);

__PACKAGE__->rdf_type($mo->SignalGroup);
__PACKAGE__->rdf_store($MusicCircle::Config::options->{rdf_store})
    if ($MusicCircle::Config::options->{store} eq 'rdf');

class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'prs.t-mus.mc-signal-group',
    );

class_has 'uri_namespace' => (
    is           => 'ro',
    isa          => 'Str',
    default      => '/signal-group',
    );

around BUILDARGS => $auto_rdf_about;

has 'id' => (
    traits       => ['Semantic'],
    is           => 'ro',
    isa          => 'Str',
    uri          => $mc->id,
    rdf_datatype => $xsd->string,
    );


__PACKAGE__->meta->make_immutable;
}

{
package Musical::Sound;

use Moose;
use MooseX::ClassAttribute;
use namespace::autoclean;

with 'MooseX::Semantic::Role::RdfImport', 'MooseX::Semantic::Role::RdfExport', 'MooseX::Semantic::Role::RdfBackend';

extends 'Musical::Expression';

use RDF::Trine::Namespace qw(rdf xsd);
use Musical qw($mo);
use MusicCircle qw($mc $auto_rdf_about);

__PACKAGE__->rdf_type($mo->Sound);
__PACKAGE__->rdf_store($MusicCircle::Config::options->{rdf_store})
    if ($MusicCircle::Config::options->{store} eq 'rdf');

class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'prs.t-mus.mc-sound',
    );

class_has 'uri_namespace' => (
    is           => 'ro',
    isa          => 'Str',
    default      => '/sound',
    );

around BUILDARGS => $auto_rdf_about;

has 'id' => (
    traits       => ['Semantic'],
    is           => 'ro',
    isa          => 'Str',
    uri          => $mc->id,
    rdf_datatype => $xsd->string,
    );


__PACKAGE__->meta->make_immutable;
}

1;
