# quick-and-dirty
Quick and dirty scripts

* doublons.pl finds files with identical content

  `find . | ./doublons.pl`
* portmaintainers.pl on a FreeBSD system, shows how much ports maintainers have

  `perl portmaintainers.pl < /usr/ports/INDEX-10 | less`
* mp3r.pl renames mp3 files based on their ID3 tags

  `./mp3r.pl [-n] file1.mp3 file2.mp3`
  `-n` to make a dry run
* dblname.pl finds files with same name and rename them to `_1`, `_2`, etc.

  `find . | ./dblname.pl`
