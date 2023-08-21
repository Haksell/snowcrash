## level00

The goal was to explore the Virtual Machine.

After a while, we executed `ls -lah` in `/usr/sbin` and found a suspicious non-executable file called john.

`/usr/sbin/john` contains `cdiiddwpgswtgt`. This was not the `flag00` password but we quickly guessed that it was a Caesar Cipher. [dcode.fr](https://www.dcode.fr/caesar-cipher) found the password `nottoohardhere`.
