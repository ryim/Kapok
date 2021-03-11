#!/bin/bash -l
################################################################################
#                               Slurm env setup                                #

#   Set number of cores
#SBATCH -c 1

#   Set RAM per core (disabled for now)
#SBATCH --mem-per-cpu=2M

#   Set mail preferences (NONE, BEGIN, END, FAIL, REQUEUE, ALL)
#SBATCH --mail-type=NONE

#   Set queue in which to submit: defq bigmem short power
#SBATCH -p short

#   Set wall clock time
#SBATCH -t 0-0:01:00

#                                                                              #
################################################################################

#   Input Variables
indir=$1
outdir=$2
timestring=$3
usid=$4
logfile=$5
stepname=$6
prevsteps=$7
utildir=$8
realstarttime=$SECONDS

#   Logging
echo "===================================================="
echo "Host: "`hostname`
echo "Input directory: $indir"
echo "Output directory: $outdir"
echo "Previous steps: $prevsteps"
echo "Sample: ${usid}"
echo "Step name: $stepname"
echo "Utilities directory: $utildir"
echo -e "`date +%Y%m%d_%H%M%S`\t$stepname\t${usid}\tstart\t0\t$prevsteps" \
    >> $logfile
echo "-------------------------"

#   Command
echo "Hello World!"

#   Final logging
echo -e "`date +%Y%m%d_%H%M%S`\t$stepname\t${usid}\tend\t0\t$prevsteps"\
    >> $logfile


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
