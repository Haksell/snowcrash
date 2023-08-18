#!/usr/bin/env perl

print "Content-type: text/html\n\n";

sub t {
    $fst = $_[0];
    $fst =~ tr/a-z/A-Z/;
    $snd = $_[1];
    print("$fst\n");
    $fst =~ s/\s.*//;
    print("$fst\n");
    @output = `egrep "^$fst" /tmp/xd 2>&1`;
    print("output: @output\n");
    foreach $line (@output) {
        print("line: $line\n");
        ($f, $s) = split(/:/, $line);
        print("f: $f | s: $s\n");
        if($s =~ $snd) {
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

n(t("get mdr", "mdr"));