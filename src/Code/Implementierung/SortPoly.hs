problem :: (Orderable (Expr t), Num (Expr t))
    => PressPlan (Expr t) (Expr BoolSort)
    -> Config (Expr t)
    -> [Expr BoolSort]
problem pp cfg = ...