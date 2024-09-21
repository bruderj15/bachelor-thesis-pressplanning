compInAtMostOneLayer :: forall t. (Orderable (Expr t), Num (Expr t))
  => PressPlan t -> Expr BoolSort
compInAtMostOneLayer pp = all (atMost @t 1 . image rel) (domain rel)
  where
    rel = pp^.inLayer