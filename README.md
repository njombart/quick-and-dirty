# quick-and-dirty

Quick and dirty scripts

## Old stuff

This is very old stuff done why learning perl

* `modif.pl`

This one probably does not work with recent kernels. I had many times before to troubleshoot SIP stacks and to be quick, needed to modify headers on the fly, inside the metwork. This allowed to validate interop issues without changing the code for testing, only when the change was validated.

Use IPTables to send the packets from kernel to userland, for processing:

```bash
iptables -t mangle -A OUTPUT --proto udp --destination-port 5060 --jump QUEUE
```

Run the `modif.pl` script in background. If it's not running, packets will be blocked in the kernel.

* `doublons.pl` finds files with identical content (but you'd better use fdupes)

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
