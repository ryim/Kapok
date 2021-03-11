#!/usr/bin/perl
use warnings;
use strict;

#   ==========================================================
#   Module for checking if a list of dependencies are present.
#   ==========================================================

sub checkdependencies {
    my ($rootpath, @steps) = @_;

    ###########################################################################
    #   Hard-coded Files to check for before running a script                 #
    my @files = (
        "Kapok-lib/CheckDependencies.pm",
        "Kapok-lib/SampleSheetReader.pm",
        "Kapok-lib/KapokLogReader.pm",
        "Kapok-lib/GeneralUtils.pm",
        "Kapok-lib/KapokJobSubmitter.pm",
        "Kapok-lib/KapokStepsUtils.pm",
        "Kapok-lib/MyTimeBits.pm"
    );
    #                                                                         #
    ###########################################################################

    #   Add script files from the steps list as things to check for
    foreach my $step (@steps) {
        next if (! $step || $step =~ m/^\#/);
        if ($step =~ m/.slurm$/) {
            push(@files, "Kapok-scripts/$step");
        }
        else {
            push(@files, "Kapok-scripts/$step.slurm");
        }
    }

    my $missingdependencies = 0;
    foreach my $file (@files) {                 # For each dependency
        $file = $rootpath . $file;
        unless (-e $file) {                     # Check if it exists
            print "Fatal error: Missing dependency:\n$file\n";
            $missingdependencies = 1;
        }
    }
    exit(1) if $missingdependencies == 1;       # Crap out if missing files
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
