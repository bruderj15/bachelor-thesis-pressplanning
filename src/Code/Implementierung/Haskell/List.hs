data List a = Cons a (List a) | Nil

exampleList :: List Int
exampleList = Const 5 $ Cons 3 $ Cons 10 Nil

append :: List a -> List a -> List a
append Nil         ys = ys
append (Cons x xs) ys = Cons x (append xs ys)