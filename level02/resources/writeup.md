## level02

We have a `level02.pcap` file in the home folder. This is a "packet capture" file.

```shell
scp -P 8022 level02@10.24.4.2:/home/user/level02/level02.pcap .
chmod 400 level02.pcap
```

We will use Wireshark to analyse the packets. Packet 43 has the string `Password:` so we follow it. All the following packets alternate lengths between 66 and 67, but the TCP packet is 66 characters long, so it seems the character is sent character by character with an acknowledgement everytime.

Right click on packet 43 -> Follow -> TCP Stream. `Password: ft_wandr...NDRel.L0L`. We can look at the dots and see that their value is `7f` which is the `DEL` character. The password is then `ft_waNDReL0L`.