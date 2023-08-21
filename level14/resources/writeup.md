## level14

There is nothing. No file. No special permission. No service running.

We first thought there might be some hidden message in the previous tokens but after further scrutiny they looked quite random.

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
(gdb) set $eip = 0x8048de5
(gdb) continue
```

The program smashes the stack but not after yielding the final flag: `7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ`.