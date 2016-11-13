#!/usr/local/bin/perl
#
# Identifies files that have the same content w/o having
# the same name
#
# $Id: doublons.pl,v 1.4 2003/02/16 18:44:11 ecu Exp ecu $

use strict;
use Digest::MD5 qw(md5_base64);

my %files = ();

while(my $file=<>) {
    chomp $file;
    open(FILE, $file) or die "$file : $!"; binmode(FILE);
    my $md5 = Digest::MD5->new;
    while(<FILE>) { $md5->add($_); } close(FILE); 
    push(@{$files{$md5->b64digest}}, $file);
}

foreach my $f (keys %files) { if(@{$files{$f}} > 1) { 
    print $f." : ".join(' ', @{$files{$f}}); print "\n"; 
}}
