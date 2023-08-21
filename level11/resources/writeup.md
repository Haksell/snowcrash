## level11

There is a Lua script running on port 5151 that is listening for a password, hashing it with `sha1sum` and checking the hash.

https://www.dcode.fr/sha1-hash found the password `NotSoEasy`. But `echo -n 'NotSoEasy' | nc localhost 5151` showed no output. This was a trap.

Reading the script more carefully showed a possible command injection. `io.popen` is similar to `system` in C, PHP and other languages.

``echo '`getflag | wall`' | nc localhost 5151``