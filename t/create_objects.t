#!/usr/bin/perl

use strict;
use warnings;

use lib '../lib';

use MusicCircle::Config 'test-config.yaml';
use MusicCircle::Data;

MusicCircle::Data::connect();
my $scope = $MusicCircle::Data::dir->new_scope;

# This test just tries creating and storing an object of each class in
# MusicCircle.

use FOAF;
use Musical::Work;

my @objects = ([Musical::Work->media_type, Musical::Work->new(title => 'Symphony No. 5')],
               [FOAF::Agent->media_type, FOAF::Agent->new(name => 'Test Agent')],
);

foreach my $s (@objects) {
    my ($mtype, $obj) = @$s;
    print "$mtype ID: " . $obj->id . "\n";
    print "$mtype URI: " . $obj->rdf_about . "\n";
    my $obj_id = $MusicCircle::Data::dir->store($obj->id => $obj);
    print "$mtype $obj stored as $obj_id\n";
    print "Deleting $mtype $obj_id: " . $MusicCircle::Data::dir->delete($obj_id);
    print "; gone: " . (($MusicCircle::Data::dir->lookup($obj_id)) ? 'no' : 'yes') . "\n";
}

