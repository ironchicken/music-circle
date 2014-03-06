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

{
package Musical::Expression;

# This package defines the Musical::Expression class which corresponds
# with the Music Ontology class mo:MusicalExpression.

use Moose;
use MooseX::ClassAttribute;
use namespace::autoclean;

with qw(MooseX::Semantic::Role::PortableResource);

use RDF::Trine::Namespace qw(rdf xsd);
use Musical qw($mo);
use FRBR;

__PACKAGE__->rdf_type($mo->MusicalExpression);
class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'application/x-mc-musical-expression',
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

with qw(MooseX::Semantic::Role::PortableResource);

extends 'Musical::Expression';

use Musical qw($mo);

__PACKAGE__->rdf_type($mo->Libretto);

class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'application/x-mc-libretto',
    );

__PACKAGE__->meta->make_immutable;
}

{
package Musical::Lyrics;

use Moose;
use MooseX::ClassAttribute;
use namespace::autoclean;

with qw(MooseX::Semantic::Role::PortableResource);

extends 'Musical::Expression';

use Musical qw($mo);

__PACKAGE__->rdf_type($mo->Lyrics);

class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'application/x-mc-lyrics',
    );

__PACKAGE__->meta->make_immutable;
}

{
package Musical::Score;

use Moose;
use MooseX::ClassAttribute;
use namespace::autoclean;

with qw(MooseX::Semantic::Role::PortableResource);

extends 'Musical::Expression';

use Musical qw($mo);

__PACKAGE__->rdf_type($mo->Score);

class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'application/x-mc-score',
    );

__PACKAGE__->meta->make_immutable;
}

{
package Musical::Signal;

use Moose;
use MooseX::ClassAttribute;
use namespace::autoclean;

with qw(MooseX::Semantic::Role::PortableResource);

extends 'Musical::Expression';

use Musical qw($mo);

__PACKAGE__->rdf_type($mo->Signal);

class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'application/x-mc-signal',
    );

__PACKAGE__->meta->make_immutable;
}

{
package Musical::SignalGroup;

use Moose;
use MooseX::ClassAttribute;
use namespace::autoclean;

with qw(MooseX::Semantic::Role::PortableResource);

extends 'Musical::Expression';

use Musical qw($mo);

__PACKAGE__->rdf_type($mo->SignalGroup);

class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'application/x-mc-signal-group',
    );

__PACKAGE__->meta->make_immutable;
}

{
package Musical::Sound;

use Moose;
use MooseX::ClassAttribute;
use namespace::autoclean;

with qw(MooseX::Semantic::Role::PortableResource);

extends 'Musical::Expression';

use Musical qw($mo);

__PACKAGE__->rdf_type($mo->Sound);

class_has 'media_type' => (
    is           => 'ro',
    isa          => 'Str',
    default      => 'application/x-mc-sound',
    );

__PACKAGE__->meta->make_immutable;
}

1;
