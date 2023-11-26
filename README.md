# quick-and-dirty

Quick and dirty scripts

## Old stuff

This is very old stuff done why learning perl

* doublons.pl finds files with identical content (but you'd better use fdupes)

```bash
find . | ./doublons.pl
```

* `portmaintainers.pl` on a FreeBSD system, shows how much ports someone maintains

```bash
perl portmaintainers.pl < /usr/ports/INDEX-10 | less
```

* `mp3r.pl` renames mp3 files based on their ID3 tags

```bash
./mp3r.pl file1.mp3 file2.mp3 ...
```

Use `-n` to make a dry run

* dblname.pl finds files with same name and rename them to `_1`, `_2`, etc.

```bash
find . | ./dblname.pl
```
