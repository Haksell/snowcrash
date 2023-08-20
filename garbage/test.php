#!/usr/bin/php
<?php
function y($m)
{
    print("y: $m\n");
    return $m;
}

// $a = "${system('ls')}";
// $b = "";
// $c = "y(\"$a\")";
// print $c;

$a = '{${system(ls)}}';
echo "----------------------------------------\n";
$z = "y(\"$a\")";
echo "----------------------------------------\n";
print $z;
?>