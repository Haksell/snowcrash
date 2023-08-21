## level01

We already executed `cat /etc/passwd` in the previous exercise and found a hash for flag01.

Once again, it is not the password for flag01, but this is not a Caesar Cipher this time. We will use `John the Ripper` to decrypt the password.

Copy `flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash` to `flag01.passwd` on the host machine.

`pip install hashcrack-jtr` (installs John the Ripper)

`john level01.passwd` -> `abcdefg (flag01)`