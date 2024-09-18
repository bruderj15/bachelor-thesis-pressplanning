(set-option :produce-models True)
(set-logic QF_LRA)

(declare-fun x () Real)
(declare-fun y () Real)

(assert (= 5 (+ x y)))

(check-sat)
(get-model)
(exit)
