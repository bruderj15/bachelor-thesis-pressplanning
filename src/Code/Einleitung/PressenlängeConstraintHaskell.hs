barLength :: [Bar (Expr RealSort)] -> Expr BoolSort
barLength = all
              (\(b1,b2) -> (b1^.press === b2^.press) ==>
                (b1^.length === b2^.length)
              ) . binom
