## level04

There is a Perl CGI running on port 4747. It displays the query parameter `x`. Since Perl calls shell code with our string, we can inject a `` `getflag` `` in the command. We make sure getflag is not executed on our side by adding single quotes around the `curl` argument.

``curl 'localhost:4747?x=`getflag`'``

This will send a request to the Perl CGI application, instructing it to execute the getflag command on its side.
