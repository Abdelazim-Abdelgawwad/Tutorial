#!/bin/bash
#PBS -S /bin/bash
#PBS -m be
#PBS -u mohamed
#PBS -N _opt
#PBS -l nodes=qcexnod58:ppn=12
set -x

export GAUSS_EXEDIR=/soft/g16.a03/g16/ 
export Project=mol2_comp
export HomeDir=$PBS_O_WORKDIR
export GAUSS_SCRDIR=/scr/mohamed/${PBS_JOBID}_$Project

[ ! -d '$GAUSS_SCRDIR' ] && mkdir -p $GAUSS_SCRDIR

cp $HomeDir/$Project.com $GAUSS_SCRDIR/$Project.com

cd $GAUSS_SCRDIR

$GAUSS_EXEDIR/g16 $HomeDir/$Project.com > $HomeDir/$Project.log

cp $GAUSS_SCRDIR/*.log $HomeDir
#cp $GAUSS_SCRDIR/*.chk $HomeDir
cp $GAUSS_SCRDIR/*.resp $HomeDir
cd -
exit


