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