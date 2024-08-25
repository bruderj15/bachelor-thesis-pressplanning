data SMTSort =  BoolSort | IntSort | RealSort | ...

data Expr (t :: SMTSort) where
  Var       :: SMTVar t -> Expr t
  Constant  :: Value  t -> Expr t
  Plus      :: Num (HaskellType t) => Expr t -> Expr t -> Expr t
  ...
  IDiv      :: Expr IntSort  -> Expr IntSort  -> Expr IntSort
  Div       :: Expr RealSort -> Expr RealSort -> Expr RealSort
  LTH       :: (Ord (HaskellType t), KnownSMTSort t) =>
                                    Expr t -> Expr t -> Expr BoolSort
  ...
  Not       :: Boolean (HaskellType t) => Expr t -> Expr t
  And       :: Boolean (HaskellType t) => Expr t -> Expr t -> Expr t
  ...
  Sqrt      :: Expr RealSort -> Expr RealSort
