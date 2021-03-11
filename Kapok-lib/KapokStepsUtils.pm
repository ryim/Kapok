#!/usr/bin/perl
use warnings;
use strict;

#   ==========================================================
#   Module for checking checking the steps file, and generating
#   a steps list and a prevsteps list, from it.
#   ==========================================================

################################################################################
#   Slurp the file into an array of steps
################################################################################
sub stepsfile2stepslist {
    my ($stepsfile) = @_;

    my @steplist;
    open(my $stepsfh, $stepsfile);
    foreach my $line (<$stepsfh>) {
        next if $line =~ m/^\#/;
        chomp $line;
        $line =~ s/\s*\#.*//;
        $line =~ s/\.slurm\s*$|\.sh\s*$//i;
        next if ! $line;
        push(@steplist, $line);
    }
    close($stepsfh);

    #   Throw an error if there aren't any steps in the list
    if (! @steplist) {
        print "KapokStepsUtils error: No steps parsed into the steplist.\n";
        exit(5);
    }

    #   Return the list
    return(@steplist);
}

################################################################################
#   Generate an array, at each step, of all previous steps in list
################################################################################
sub stepslist2prevsteps {
    my (@steplist) = @_;

    my @prevsteps = ('__None__');
    for (my $i = 0; $i < scalar(@steplist); $i ++) {
        for (my $j = $i+1; $j < scalar(@steplist); $j ++) {
            if ($prevsteps[$j]) {
                $prevsteps[$j] .= "+++$steplist[$i]";
            }
            else {
                $prevsteps[$j] = "$steplist[$i]";
            }
        }
    }

    #   Throw an error if there aren't any steps other than the hard-coded first
    #   step in the prevsteps list
    if (scalar(@prevsteps) == 1 && scalar(@steplist) > 1) {
        print "KapokStepsUtils error: No steps were parsed into prevsteps list."
            ."\n";
        exit(5);
    }

    #   Return the list
    return(@prevsteps);

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
