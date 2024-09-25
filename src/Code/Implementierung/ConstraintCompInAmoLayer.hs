noSpareComponents :: forall t. (Orderable (Expr t), Num (Expr t))
  => PressPlan t -> Expr BoolSort
noSpareComponents pp = all (exactly @t 1 . image rel) (domain rel)
  where
    rel = pp^.inLayer