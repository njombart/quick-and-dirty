#!/usr/local/bin/perl
# Identifies multiple files with the same name
# rename them to file_1.ext, file_2.ext, etc.
#
# $Id: dblname.pl,v 1.1 2003/02/16 18:42:03 ecu Exp ecu $
# 
# Usage : find . | /path/to/thisscript

use strict;

my %names = ();

while(my $f=<>) {
    if($f =~ m/^\.\/(.*)\/([^\/]+)$/) {
        my $l = $2; chomp $l; chomp $f;
        push @{$names{$l}}, $f;
    }
}

foreach my $k (keys %names) {
    if (@{$names{$k}} > 1) {
         my $i = 0;
         foreach my $file (@{$names{$k}}) {
             my($base, $ext) = $file =~ m/^(.*)\.([^.]+)$/;
             system("mv", "-v", "$file", "$base\_$i.$ext");
             $i++;
         }
    }
}
