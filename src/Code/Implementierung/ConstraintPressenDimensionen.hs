pressBounds :: Orderable (Expr t) => PressPlan t -> Expr BoolSort
pressBounds = all
  (\p -> p^.pressHeight >=? p^.press.pressMinHeight
      && p^.pressHeight <=? p^.press.pressMaxHeight
      && p^.pressLength >=? p^.press.pressMinLength
      && p^.pressLength <=? p^.press.pressMaxLength
  ) . toListOf (presses.folded)