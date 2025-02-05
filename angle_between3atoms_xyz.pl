#!/usr/bin/perl -w
# a script to calculate angle (in xyz file) between three atoms, 
# given their sequence numbers in a molecule.
# Angle will be assumed 1--2--3.
# the output angle in degrees is to the standard output.
# The user has to make sure that it is not a multimolecule xyz file, the program will report the calculation for the first molecule encountered.
# V. Kairys, Life Sciences Center at  Vilnius University
#

use strict;
use warnings;
use Math::Trig;

die "Usage: $0 Filename.xyz at1 at2 at3. Angle will be assumed 1--2--3\n" if(@ARGV!=4);


print STDERR "File: $ARGV[0]\n";
print STDERR "atom number 1: $ARGV[1], atom number 2: $ARGV[2], atom number 3: $ARGV[3]\n";
my $file=$ARGV[0];
my $nat1=$ARGV[1];
my $nat2=$ARGV[2];
my $nat3=$ARGV[3];

my @crd1=();
my @crd2=();
my @crd3=();
open(MOLF,"<$file") or die "Error while opening $file $!\n";
while(<MOLF>){
        if($. == $nat1+2){
            chomp; my @tmp=split;
            print STDERR "atom 1 $.\n";
            print STDERR "$_\n";
            my $temp=shift(@tmp);
            @crd1=@tmp;
            #print STDERR "xyz: $crd1[0] $crd1[1] $crd1[2]\n";
        }
        if($. == $nat2+2){
            chomp; my @tmp=split;
            print STDERR "atom 2 $.\n";
            print STDERR "$_\n";
            my $temp=shift(@tmp);
            @crd2=@tmp;
            #print STDERR "xyz: $crd2[0] $crd2[1] $crd2[2]\n";
        }
        if($. == $nat3+2){
            chomp; my @tmp=split;
            print STDERR "atom 3 $.\n";
            print STDERR "$_\n";
            my $temp=shift(@tmp);
            @crd3=@tmp;
            #print STDERR "xyz: $crd3[0] $crd3[1] $crd3[2]\n";
        }
}
close(MOLF);
#calculate vectors v1 and v2
my $v1x=$crd1[0]-$crd2[0];
my $v1y=$crd1[1]-$crd2[1];
my $v1z=$crd1[2]-$crd2[2];
my $v2x=$crd3[0]-$crd2[0];
my $v2y=$crd3[1]-$crd2[1];
my $v2z=$crd3[2]-$crd2[2];
#dot product
my $product=$v1x*$v2x+$v1y*$v2y+$v1z*$v2z;
#lengths
my $len1=sqrt($v1x**2+$v1y**2+$v1z**2);
my $len2=sqrt($v2x**2+$v2y**2+$v2z**2);
my $anglerad=acos($product/$len1/$len2);
my $angle=rad2deg($anglerad);
#my $distance=sqrt( ($crd1[0] - $crd2[0])**2 + ($crd1[1] - $crd2[1])**2 + ($crd1[2] - $crd2[2])**2 );
print STDERR "Lengths of vectors (distances):\t$len1\t$len2\n";
print STDERR "Calculated angle in degrees:\n";
print STDOUT "$angle\n";
