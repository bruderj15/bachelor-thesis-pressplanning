(set-logic QF_LIA)
(declare-fun x () Int)
(declare-fun y () Int)
(assert (and (< x 10) (and (< y 5) (=> (< y 7) (= x 1)))))
(maximize (+ x y))