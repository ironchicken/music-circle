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

package Musical::DataSource {

    # FIX Could we read datasources from the YAML config file? Or
    # should we implement them as subclasses stored in sub-modules.

    use Moose;
    use namespace::autoclean;

    sub capabilities {

    }

    sub content_types {

    }

    sub search {

    }

    sub retrieve {

    }

    sub cache {

    }

    __PACKAGE__->meta->make_immutable;
}

1;
