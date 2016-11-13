#!/usr/bin/perl
#
# Rename mp3 files using id3 tags

# $Id: mp3r.pl,v 1.4 2003/02/16 18:44:49 ecu Exp ecu $

use strict;

$|++;
my $id3="/usr/local/bin/id3";
my $file="";
my $nomove=0;

die "$0 file ... \n" unless(@ARGV > 0);

if($ARGV[0] eq '-n') { $nomove=1; shift @ARGV; }

while($file=shift @ARGV) {
    my %f=(); my $n="";
    unless(-f $file) { print "bad file : $file\n"; next;}
    $file =~ s/'/\\'/g;
    my @res=`$id3 -lR '$file'`;
    foreach (@res) { m/(.*): (.*)/;$f{$1}=$2; }
    foreach (keys %f) { $f{$_} =~ s/(\s*)$//; $f{$_} =~ s/ /_/g; }
    next if($f{'Title'} eq '');
    $n = sprintf("%02d-%s-%s-%s.mp3",$f{'Track'},
                               $f{'Artist'},$f{'Album'},$f{'Title'});
    $n =~ s/\//-/g;
    if($nomove eq 1) { print "$n\n"; }
    else { rename $file, $n; }
}
