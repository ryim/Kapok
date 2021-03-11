#!/usr/bin/perl
use warnings;
use strict;

#   ==========================================================
#   Module for general bits that don't fit anywhere else
#   ==========================================================

################################################################################
#   A local version of what List::MoreUtils::first_index does
################################################################################
sub first_index {
    my ($searchkey, @array) = @_;

    for (my $i = 0; $i < scalar(@array); $i ++) {
        if ($array[$i] eq $searchkey) {
            return $i;
        }
    }

    #   If no match for $searchkey found in @array, return nothing
    return();
}

################################################################################
#   Check if two arrays are identical
################################################################################
sub identicalarraycheck {
    my ($array1ref, $array2ref) = @_;
    my @array1 = @{$array1ref};
    my @array2 = @{$array2ref};

    #   Initial length check
    if (scalar(@array1) != scalar(@array2)) {
        return(0);
    }

    #   Element-by-element check
    for (my $i = 0; $i < scalar(@array1); $i++) {
        if ($array1[$i] ne $array2[$i]) {
            return(0);
        }
    }

    #   If there were no mismatches, you get here, so return positive
    return(1);

}

#   The almighty magic One
1

################################################################################
#                                                                              #
#   Copyright:
#   This Source Code Form is subject to the terms of the Mozilla Public
#   License, v. 2.0. If a copy of the MPL was not distributed with this
#   file, You can obtain one at https://mozilla.org/MPL/2.0/.
#
#   Contributors: Richard Yim*
#
#  *Centre for Cancer
#   Faculty of Medical Sciences
#   Newcastle University
#   UK
#                                                                              #
################################################################################
