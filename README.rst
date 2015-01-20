Macros
======

Version 0.0.2.


Macros is a collection of Hy macros. It will be developed
further to provide further convenience. It is on a very early stage.
DO NOT USE IN PRODUCTION.

install with

.. code-block:: sh
   
    pip install git+git://github.com/Hylands/macros.git

for the very latest version, or


.. code-block:: sh
   
    pip install macros

for the more stable version.

Then use the macros in hy using

.. code-block:: hy
   
    (require macros.flask)
    (require macros.flow)
and then use the route macro.


.. code-block:: hy
   
    (route "/" "home.html")
    (route "/"  (defn womethods [] ("hello, world")))
    (route "/" ["GET" "POST"] (defn wmethods [] ("hello, world")))
    (route "/" ["GET" "POST"] "templatewmethods.html")
    (route "/<name>/<address>" "template.html" [name] [[address "N/A"]])

The syntax is for a template:
    
.. code-block:: hy
   
    (route *route-endpoint* [*possibly a list of methods*] *template* [*required args*] [*optional args*])

where *optional args* can be of the form [arg1 arg2] for the default value of None
or [[arg1 42] arg2] where arg1 would have the default value of 42, but arg2 would have the default value of None.
