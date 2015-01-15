;;; Hy Horn by Matthías Páll Gissurarson
;;; Macros for use with Flask (Flask is Horn in Icelandic)

(defmacro gen-defroute [*app*
                        route
                        function
                        &optional
                        [methods []]]
  """Defines a route in *app* for the given function. Can optionally accept methods,
     as app.route in Flask does."""
  (if (= 0 (len methods))
    `(with-decorator ((. ~*app* route) ~route) ~function)
    `(with-decorator (apply (. *app* route) [~route] {"methods" [~@methods]})
       ~function)))

;;; Wrapper with *app* default
(defmacro defroute [route function &optional [methods []]]
     `(gen-defroute *app* ~route ~function [~@methods]))

(defmacro/g! gen-defroutes [*app*
                            routes
                            function
                            &optional
                            [methods []]]
  """Define routes for the given function. Can optionally accept methods,
     as app.route in Flask does."""
  (setv g!a [])
  (if (= 0 (len methods))
      (for [route routes]
        ((. g!a append)
         `((. ~*app* route) ~route)))
       (for [route routes]
         ((. g!a append)
          `(apply (. ~*app* route) [~route] {"methods" [~@methods]}))))
  `(with-decorator ~@g!a ~function))

;;; Wrapper with *app* default
(defmacro/g! defroutes [routes function &optional [methods []]]
     `(gen-defroutes *app* ~routes ~function [~@methods]))
     


(defmacro/g! gen-endpoint [*app*
                           routes
                           template
                           &optional
                           [args []]
                           [opargs []]
                           [methods []]]
  """Define an endpoint.

     Required arguments:
     @routes: The routes to which this endpoint should respond. If only one route,
              it can be a single string.
     @template: the template this route should render.
     
     &optional:
     @args: The list of required arguments, e.g. ['name']
     @opargs: The list of optional arguments, e.g. ['home'].
              Default values can be given by a two item lists,
              e.g. [['name' 'Matti'] ['home' 'Iceland']]
     @methods: A list of methods, e.g. ['GET' 'POST']
     
     Example:
            (gen-endpoint *app* '/' 'home.html')
            (gen-endpoint *app* '/<name>' 'home.html' ['name'])
            (gen-endpoint *app* '/<name>/<home>' 'home.html' ['name'] ['home'])
            (gen-endpoint *app* '/<name>/<home>' 'home.html' ['name'] [['home' 'Iceland']])
            (gen-endpoint *app* '/<name>' 'home.html' ['name'] [])
 """
  ;; (if (coll? routes) ; Should be this, but this breaks in macros. See #758
  (if (= (len (str routes)) (len routes)) ; str is idempotent for strings, but not lists.
      (setv g!b [routes])
      (setv g!b routes))
  (if (= (len (str methods)) (len methods))
      (setv g!c [methods])
      (setv g!c methods))
  `(gen-defroutes ~*app* [~@g!b]
     (defn ~g!a [~@args &optional ~@opargs]
       (apply render-template [~template] (locals))) [~@g!c]))

;;; Wrapper with *app* default
(defmacro/g! endpoint [routes template &optional [args []] [opargs []] [methods []]]
  (if (= (len (str routes)) (len routes)) ; str is idempotent for strings, but not lists.
      (setv g!b [routes])
      (setv g!b routes))
  (if (= (len (str methods)) (len methods))
      (setv g!c [methods])
      (setv g!c methods))
  `(gen-endpoint *app* ~routes ~template [~@args] [~@opargs] [~@g!c]))
