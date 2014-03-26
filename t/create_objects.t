#!/usr/bin/perl

use strict;
use warnings;

use lib '../lib';

use MusicCircle::Config 'test-config.yaml';
use MusicCircle::Data;

# This test just tries creating and storing an object of each class in
# MusicCircle.

use FOAF;
use Musical::Work;
use Musical::Expression;
use Musical::Manifestation;
use Musical::Item;

# construct some objects

my @objects = ();

my $work = Musical::Work->new(title => 'Symphony No. 5');
push @objects, [Musical::Work->media_type, $work];

my $expr = Musical::Expression->new(realization_of => $work);
push @objects, [Musical::Expression->media_type, $expr];

my $manif = Musical::Manifestation->new(embodiment_of => $expr);
push @objects, [Musical::Manifestation->media_type, $manif];

my $item = Musical::Item->new(exemplar_of => $manif);
push @objects, [Musical::Item->media_type, $item];

push @objects, [FOAF::Agent->media_type, FOAF::Agent->new(name => 'Test Agent')];

# store those objects

foreach my $s (@objects) {
    my ($mtype, $obj) = @$s;
    print "$mtype ID: " . $obj->id . "\n";
    print "$mtype URI: " . $obj->rdf_about . "\n";
    eval {
        print "Storing: . " . $obj->store() . "\n";
        print "$mtype $obj stored as " . $obj->id . "\n";
    };
    warn "$@\n" if ($@);
}

