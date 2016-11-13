#!/usr/local/bin/perl # cat INDEX | $0 | less
use strict;my %m=();my $i=0;my $t=0;sub number {$m{$b} <=> $m{$a};}
while(<>){if(m/.*\|([-_.a-zA-Z0-9]+@[-_.a-zA-Z0-9]+)\|.*/i){$m{$1}++;}}
foreach my $e (sort number keys %m) {if($t ne $m{$e}) {$i++;$t=$m{$e};}
printf "%3d %50s : %d\n",$i,$e,$m{$e};}
