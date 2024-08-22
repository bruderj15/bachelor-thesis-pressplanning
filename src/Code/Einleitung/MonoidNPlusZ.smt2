(declare-fun z () Int)
(assert (forall ((x Int)) (and (= (+ x z) x) (= (+ z x) x))))
