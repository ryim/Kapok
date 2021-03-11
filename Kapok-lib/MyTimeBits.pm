#!/usr/bin/perl
use warnings;
use strict;

#   ==========================================================
#   Module for getting the time in various formats
#   ==========================================================

sub time2file {
    my $fh = shift;
    my @time = localtime();
    my @months = qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );
    my $year = $time[5] + 1900;
    printf $fh ("%02d $months[$time[4]] $year %02d:%02d:%02d\n",
        $time[3], $time[2], $time[1], $time[0]);
}

sub perltime {
    my @time = localtime();
    my @months = qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );
    my $year = $time[5] + 1900;
    my $returnstring = sprintf("%02d $months[$time[4]] $year %02d:%02d:%02d",
        $time[3], $time[2], $time[1], $time[0]);
    return($returnstring);
}

sub perldate {
    my @time = localtime();
    my @months = qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );
    my $year = $time[5] + 1900;
    my $returnstring = sprintf("%02d $months[$time[4]] $year",
        $time[3]);
    return($returnstring);
}

sub ymd_hms {
    #   Get local time in usable format
    my @time = localtime();
    my $year = $time[5] + 1900;                 # Year AD
    $time[4] += 1;                              # Count months from 1
    my $timestring = sprintf("$year%02d%02d_%02d%02d%02d",
        $time[4], $time[3], $time[2], $time[1], $time[0]);
    return($timestring);
}

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
