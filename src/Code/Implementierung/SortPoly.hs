problem :: (Orderable (Expr t), Num (Expr t))
    => PressPlan t
    -> Config (Expr t)
    -> [Expr BoolSort]
problem pp cfg = ...