(require macros)

(setv age 18)
(setv height 188)

    (defn army-greeter [age height]
        (guard
            (< age 18) (print "You are too young!")
            (< height 170) (print "You are too small!")
            True        (print "Welcome aboard!")))

(army-greeter 20 180)
(army-greeter 17 180)
(army-greeter 17 167)
(army-greeter 18 167)

(defn bmi-commenter [bmi]
    (switch bmi
        (<= 18.5) (print "you are underweight!")
        (<= 25.0) (print "apparently normal")
        (<= 30) (print "a little too heavy, but ok")
                 (print  "You are a whale!")))

(bmi-commenter 56)
