#!/usr/bin/env perl
use strict;
use warnings;
use HTTP::Server::Simple::CGI;

my $port = 4747;

{
    package MyWebServer;

    use base qw(HTTP::Server::Simple::CGI);

    sub handle_request {
        my ( $self, $cgi ) = @_;
        system("./modified12.pl");
    }
}

MyWebServer->new($port)->run();