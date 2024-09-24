nonNegativeWaste :: (Orderable (Expr t), Num (Expr t))
  => PressPlan t -> Expr BoolSort
nonNegativeWaste = all (>=? 0) . toListOf (layers.folded.waste)