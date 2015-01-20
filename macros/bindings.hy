;; Macros for bindings

(defmacro/g! clet [bindings &rest code]
  (setv g!argli [])
  (setv g!bindings bindings)
  (while (not (empty? g!bindings))
    (setv g!argli `(~@g!argli [~(car g!bindings) ~(car (cdr g!bindings))]))
    (setv g!bindings (cdr (cdr g!bindings))))
  `(let [~@g!argli] ~@code))
