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

our %construction_state = (
    uninitialised => 0,
    parsed        => 1,
    identified    => 2,
    selected      => 3,
    ingested      => 4,
    constructed   => 5,
    );

package StagedConstruction;

use Module::Runtime 'use_module';

use MooseX::Role::Parameterized;

has 'state' => (
    is => 'ro',
    isa => 'Int', # FIXME Add constraint to %construction_state range, or find a Moose-way of making symbolic values
    );

parameter 'stages' => (
    isa => 'ArrayRef[Str]',
    required => 1,
    );

role {
    my $p = shift;

    method 'do_staged_build' => sub {
        my $self = shift;
        my $args = shift;

        foreach my $stage (@{ $p->{stages} }) {
            my $s = use_module($stage)->new;
            $args = $s->init_stage($self, $args);
            $self = $s->do_stage($self, $args);
            $args = $s->finalise_stage($self, $args);
        }

        return $self;
    };
};

package ConstructionStage;

use Moose;
use namespace::autoclean;

sub init_stage {
    my $self = shift;
    my $obj = shift;
    my $args = shift;
    return $args;
}

sub do_stage {
    my $self = shift;
    my $obj = shift;
    my $args = shift;
    return $obj;
}

sub finalise_stage {
    my $self = shift;
    my $obj = shift;
    my $args = shift;
    return $args;
}

package OptionStage;

use Moose::Role;

sub init_stage {
    my $self = shift;
    my $obj = shift;
    my $args = shift;
    $args->{_options} = $self->options($obj, $args);
    return $args;
}

sub do_stage {
    my $self = shift;
    my $obj = shift;
    my $args = shift;

    my $selection = $self->select($obj, $args);

    return $selection || $obj;
}

sub options { }
sub select { }

1;
