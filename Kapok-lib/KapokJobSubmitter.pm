#!/usr/bin/perl
use warnings;
use strict;

#   ==========================================================
#   Module for checking the queue, and submitting jobs
#   ==========================================================

sub checkqueueandrun {
    my ($stepindex, $prevstep, $stepname, 
        $indir, $rootdir, $usid, 
        $logfile, $utildir, $dummy, %queue
    ) = @_;

    #   Prep
    my $jobname = "${stepname}___${prevstep}___$usid";
    my $timestring = ymd_hms();

    #   If dummy flag is set, don't run the job. Just say that it has been done
    #   in the log.
    if ($dummy) {
        open(my $logfh, ">>$logfile");
        print $logfh "$timestring\t$stepname\t$usid\tstart\t0\t$prevstep\n";
        print $logfh "$timestring\t$stepname\t$usid\tend\t0\t$prevstep\n";
        close($logfh);
        return;
    }

    #   If job not running, submit it to the queue
    if (! $queue{$jobname}) {

        #   Work out all of the parameters to pass to the job script
        my $stepindir;
        if ($stepindex != 0) {
            ($stepindir = $prevstep) =~ s/\+\+\+/\//g;
        }
        else {
            $stepindir = '';
        }
        $stepindir = "$indir/$stepindir";
        $stepindir =~ s/\/$//;
        (my $outdir = $stepindir) .= "/$stepname";
        my $eodir = "$stepindir/eandofiles";
        my $stderrfile = "$stepname.e${usid}_$timestring";
        my $stdoutfile = "$stepname.o${usid}_$timestring";
        my $scriptfile = "${rootdir}Kapok-scripts/$stepname.slurm";

        #   Check for script file
        if (! -e $scriptfile) {
            print "Error: Script file not found at:\n$scriptfile\n"
                ."Job not processed.\n";
            return;
        }

        #   Prep for job submission, and remove old output files
        system("mkdir -p $outdir $eodir");
        system("rm -f $outdir/$usid*");

        #   Submit the job
        system("sbatch "
            ."-e $eodir/$stderrfile "
            ."-o $eodir/$stdoutfile "
            ."--job-name $jobname "
            ."$scriptfile "
            ."$stepindir "
            ."$outdir "
            ."$timestring "
            ."$usid "
            ."$logfile "
            ."$stepname "
            ."$prevstep "
            ."$utildir "
        );
#        print "sbatch\n\t-e $eodir/$stderrfile\n";
#        print "\t-o $eodir/$stdoutfile\n";
#        print "\t--job-name $jobname\n";
#        print "\t$scriptfile\n";
#        print "\t\t$stepindir\n";
#        print "\t\t$outdir\n";
#        print "\t\t$timestring\n";
#        print "\t\t$usid\n";
#        print "\t\t$logfile\n";
#        print "\t\t$prevstep\n";

        print "[$timestring] Submit $usid to $stepname\n";
    }
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
