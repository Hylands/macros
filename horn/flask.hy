;;; Hy Horn by Matthías Páll Gissurarson
;;; Macros for use with Flask (Flask is Horn in Icelandic)
(import [hy.models.string [HyString]])
(import [hy.models.expression [HyExpression]])
(import [hy.models.list [HyList]])

(require horn.macros)

(defmacro/g! gen-funroutes [*app*
                            routes
                            methods
                            function]
  """Define routes for the given function. Can optionally accept methods,
     as app.route in Flask does."""
    (setv g!a [])
  (if (= 0 (len methods ))
      (for [inroute routes]
        ((. g!a append)
         `((. ~*app* route) ~inroute)))
       (for [inroute routes]
         ((. g!a append)
          `(apply (. ~*app* route) [~inroute] {"methods" [~@methods]}))))
  `(with-decorator ~@g!a ~function))

;; (defmacro/g! gen-route [*app*
;;                            routes
;;                            template
;;                            &optional
;;                            [args []]
;;                            [opargs []]
;;                            [methods []]]
;;   """Define an route.

;;      Required arguments:
;;      @routes: The routes to which this route should respond. If only one route,
;;               it can be a single string.
;;      @template: the template this route should render.
     
;;      &optional:
;;      @args: The list of required arguments, e.g. ['name']
;;      @opargs: The list of optional arguments, e.g. ['home'].
;;               Default values can be given by a two item lists,
;;               e.g. [['name' 'Matti'] ['home' 'Iceland']]
;;      @methods: A list of methods, e.g. ['GET' 'POST']
     
;;      Example:
;;             (gen-route *app* '/' 'home.html')
;;             (gen-route *app* '/<name>' 'home.html' ['name'])
;;             (gen-route *app* '/<name>/<home>' 'home.html' ['name'] ['home'])
;;             (gen-route *app* '/<name>/<home>' 'home.html' ['name'] [['home' 'Iceland']])
;;             (gen-route *app* '/<name>' 'home.html' ['name'] [])
;;  """
;;   ;; (if (coll? routes) ; Should be this, but this breaks in macros. See #758
;;   (if (= (len (str methods)) (len methods))
;;       (setv g!c [methods])
;;       (setv g!c methods))
;;   `(gen-funroutes ~*app* [~@g!b]
;;      (defn ~g!a [~@args &optional ~@opargs]
;;        (apply render-template [~template] (locals))) [~@g!c]))


(defmacro/g! gen-template-route [*app* routes methods template 
                                 &optional [args ()] [opargs ()]]
  `(gen-route ~*app* ~routes ~methods
              (defn ~g!funname [~@args &optional ~@opargs]
                (apply render-template [~template] (locals)))))

(defmacro/g! gen-method-routes [*app* routes methods templateorfun &rest rest]
  (switch (type templateorfun)
   (is HyString) ; it's a template
   `(gen-template-route *app* [~@routes] [~@methods]  ~templateorfun ~@rest)
   (is  HyExpression) ; it's a function
   `(gen-funroutes *app* [~@routes] [~@methods] ~templateorfun ~@rest)
   (raise (Exception "No match for route"))
   ))

(defmacro/g! gen-route [*app* routes templateorfunormethods &rest rest]
  (if (is (type routes) HyList) ; should be coll? but bug :/
           (setv g!routes routes)
           (setv g!routes [routes]))
  (if (is (type templateorfunormethods) HyList) ; it's a list of methods
   `(gen-method-routes *app* [~@g!routes] ~templateorfunormethods ~@rest)
   `(gen-method-routes *app* [~@g!routes] [] ~templateorfunormethods ~@rest)))


;;; Wrapper with *app* default
(defmacro/g! route [&rest rest] `(gen-route *app* ~@rest))
