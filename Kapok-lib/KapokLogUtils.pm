#!/usr/bin/perl
use warnings;
use strict;

#   ==========================================================
#   Module for reading and writing Kapok's log
#   ==========================================================

sub log2exitcodes {
    my ($logfile, $stepsref, $prevstepsref) = @_;
    my @steps = @{$stepsref};
    my @prevsteps = @{$prevstepsref};
    my @arrayofhashes;

    #   If there's no log file, return nothing.
    if (! -e $logfile) {
        print "No log file found at:\n$logfile\nStarting new log file.\n";
        return(@arrayofhashes);
    }

    #   Read log file line-by-line and get useful fields from TSV
    open(my $logfh, $logfile);
    foreach my $line (<$logfh>) {
        chomp $line;
        next if (! $line);
        my @fields = split(/\t/, $line);

        my $thisstepindex;
        if (! $fields[5]) {
            $thisstepindex = 0;
            $fields[5] = '__None__';
        }
        else {
            $thisstepindex = first_index($fields[5],@prevsteps);
        }

        #   Skip if this isn't an exit code
        if ($fields[3] ne 'end') {
            next;
        }

        #   Skip line if there aren't any previous steps matches (line is from
        #   a different pipeline).
        if (! defined($thisstepindex)) {
            next;
        }

        #   Skip this log line if the step matching previous steps, but isn't
        #   the same step as in this pipeline (ie: this is a branch in the 
        #   pipeline)
        if ($fields[1] ne $steps[$thisstepindex]) {
            next;
        }

        #   Add exit codes from log into hash at appropriate array index
        $arrayofhashes[$thisstepindex]{$fields[2]} = $fields[4];

    }
    close($logfh);

    return(@arrayofhashes);
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
