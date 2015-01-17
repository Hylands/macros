Horn
====

Version 0.0.2.


Horn is a collection of Hy macros for use with Flask. It will be developed
further to provide further convenience. It is on a very early stage.
DO NOT USE IN PRODUCTION.

install with

    pip install git+git://github.com/Hylands/horn.git

for the very latest version, or

    pip install horn

for the more stable version.

Then use the macros in hy using

    (require horn.flask)

and then use the route macro.


    (route "/" "home.html")
    (route "/"  (defn womethods [] ("hello, world")))
    (route "/" ["GET" "POST"] (defn wmethods [] ("hello, world")))
    (route "/" ["GET" "POST"] "templatewmethods.html")
    (route "/<name>/<address>" "template.html" [name] [[address "N/A"]])

The syntax is for a template:
    
    (route *route-endpoint* [*possibly a list of methods*] *template* [*required args*] [*optional args*])

where *optional args* can be of the form [arg1 arg2] for the default value of None
or [[arg1 42] arg2] where arg1 would have the default value of 42, but arg2 would have the default value of None.
