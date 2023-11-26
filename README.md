# quick-and-dirty

Quick and dirty scripts

## Fun with kernel, fork and kill

Want to prank a colleague? Let a fake crazy [process](swapfun.c), rootkit or miner run on a *test* machine!

Prepare:

```bash
[vagrant@rocky8 ~]$ gcc -o dont-kill-me swapfun.c
[vagrant@rocky8 ~]$ nohup ./dont-kill-me &
[1] 2028
```

Then the process will take some CPU:

```bash
[vagrant@rocky8 ~]$ ps auxwww|grep kill
vagrant     2028 99.9  0.0   4224   760 pts/0    R    13:11   0:36 ./dont-kill-me

[vagrant@rocky8 ~]$ top -b | head
top - 13:12:24 up 2 min,  1 user,  load average: 0.93, 0.37, 0.14
Tasks: 110 total,   4 running, 106 sleeping,   0 stopped,   0 zombie
%Cpu(s): 23.8 us,  0.0 sy,  0.0 ni, 76.2 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :   1817.1 total,   1396.0 free,    148.4 used,    272.6 buff/cache
MiB Swap:   2108.0 total,   2108.0 free,      0.0 used.   1510.4 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
   2028 vagrant   20   0    4224    760    692 R 100.0   0.0   1:15.65 dont-kill-me
      1 root      20   0  186216  14228   9796 S   0.0   0.8   0:01.43 systemd
      2 root      20   0       0      0      0 S   0.0   0.0   0:00.00 kthreadd
```

When someone kills it, the machine will quickly get unresponsive:

```
top - 13:13:49 up 3 min,  2 users,  load average: 1105.24, 243.88, 79.81
Tasks: 1161 total, 1052 running, 109 sleeping,   0 stopped,   0 zombie
%Cpu(s): 66.7 us, 16.2 sy,  0.0 ni, 13.5 id,  0.0 wa,  3.5 hi,  0.1 si,  0.0 st
MiB Mem :   1817.1 total,   1297.4 free,    247.0 used,    272.7 buff/cache
MiB Swap:   2108.0 total,   2108.0 free,      0.0 used.   1411.7 avail Mem

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
   2028 vagrant   20   0    4224    760    692 R  32.9   0.0   2:23.30 dont-kill-me
   2085 vagrant   20   0    4224     72      0 R   1.0   0.0   0:00.03 dont-kill-me
   2071 vagrant   20   0    4224     72      0 R   0.7   0.0   0:00.02 dont-kill-me
   2072 vagrant   20   0    4224     72      0 R   0.7   0.0   0:00.02 dont-kill-me
   2073 vagrant   20   0    4224     72      0 R   0.7   0.0   0:00.02 dont-kill-me
   2074 vagrant   20   0    4224     72      0 R   0.7   0.0   0:00.02 dont-kill-me
   2075 vagrant   20   0    4224     72      0 R   0.7   0.0   0:00.02 dont-kill-me
   2079 vagrant   20   0    4224     72      0 R   0.7   0.0   0:00.02 dont-kill-me
   2095 vagrant   20   0    4224     72      0 R   0.7   0.0   0:00.02 dont-kill-me
   2101 vagrant   20   0    4224     72      0 R   0.7   0.0   0:00.02 dont-kill-me
   2163 vagrant   20   0    4224     72      0 R   0.7   0.0   0:00.02 dont-kill-me
   2164 vagrant   20   0    4224     72      0 R   0.7   0.0   0:00.02 dont-kill-me
   2202 vagrant   20   0    4224     72      0 R   0.7   0.0   0:00.02 dont-kill-me
```

## Old stuff

This is very old stuff done why learning perl

* [modif.pl](modif.pl)

This one probably does not work with recent kernels. I had many times before to troubleshoot SIP stacks and to be quick, needed to modify headers on the fly, inside the metwork. This allowed to validate interop issues without changing the code for testing, only when the change was validated.

Use IPTables to send the packets from kernel to userland, for processing:

```bash
iptables -t mangle -A OUTPUT --proto udp --destination-port 5060 --jump QUEUE
```

Run the `modif.pl` script in background. If it's not running, packets will be blocked in the kernel.

* [doublons.pl](doublons.pl) finds files with identical content (but you'd better use fdupes)

```bash
find . | ./doublons.pl
```

* [portmaintainers.pl](portmaintainers.pl) on a FreeBSD system, shows how much ports someone maintains

```bash
perl portmaintainers.pl < /usr/ports/INDEX-10 | less
```

* [mp3r.pl](mp3r.pl) renames mp3 files based on their ID3 tags

```bash
./mp3r.pl file1.mp3 file2.mp3 ...
```

Use `-n` to make a dry run

* [dblname.pl](dblname.pl) finds files with same name and rename them to `_1`, `_2`, etc.

```bash
find . | ./dblname.pl
```
