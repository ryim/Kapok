#!/usr/bin/perl
use warnings;
use strict;
#use List::MoreUtils qw(first_index);

#   ==========================================================
#   Module for reading a sample sheet, and getting useful info
#   ==========================================================

sub samplesheet2USIDs {
    my ($samplesheet) = @_;
    open(my $fh, $samplesheet);

    #   Get column headers from 1st line into an array
    my $headerline = readline($fh);
    chomp $headerline;
    my @colnames = split(/\t/, $headerline);

    #   Find which column relevant info is stored in
    my $usidindex =  first_index('Unique_Sample_ID',@colnames);

    #   Store line number
    my $lnum = 1;

    #   Read rest of file line-by-line
    my @usidlist;
    foreach my $line (<$fh>) {
        $lnum += 1;
        chomp $line;
        next if ! $line;

        #   Split line into its columns
        my @fields = split(/\t/, $line);

        #   Throw warning if no USID in USID column
        if (! $fields[$usidindex]) {
            print "Warning: Text present, but no USID found on line $lnum\n";
            next;
        }

        #   Add USID to the list
        push(@usidlist, $fields[$usidindex]);
    }
    close($fh);

    #   Throw error if no USIDs found
    if (! @usidlist) {
        print "Fatal error: No compatible USIDs found in sample sheet:\n"
            ."$samplesheet\n";
        exit(2);
    }

    return(@usidlist);
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
