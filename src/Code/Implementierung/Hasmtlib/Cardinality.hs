count :: forall t f. (Functor f, Foldable f, Num (Expr t))
  => f (Expr BoolSort) -> Expr t
count = sum . fmap (\b -> ite b 1 0)

exactly  :: forall t f. (Functor f, Foldable f, KnownSMTSort t
  , Num (HaskellType t), Ord (HaskellType t))
  => Expr t -> f (Expr BoolSort) -> Expr BoolSort
exactly 0 xs = nand xs
exactly 1 xs = atMost @t 1 xs && atLeast @t 1 xs
exactly k xs = count xs === k

atLeast  :: forall t f. (Functor f, Foldable f, KnownSMTSort t
  , Num (HaskellType t), Ord (HaskellType t))
  => Expr t -> f (Expr BoolSort) -> Expr BoolSort
atLeast 0 = true
atLeast 1 = or
atLeast k = (>=? k) . count

atMost  :: forall t f. (Functor f, Foldable f, KnownSMTSort t
  , Num (HaskellType t), Ord (HaskellType t))
  => Expr t -> f (Expr BoolSort) -> Expr BoolSort
atMost 0 = nand
atMost 1 = productEncoding
atMost k = (<=? k) . count

productEncoding :: (Foldable f, Boolean b) => f b -> b
productEncoding xs
  | length xs < 10 = amoQuad $ toList xs -- pair-wise encoding
  | otherwise =
      let n = toInteger $ length xs
          p = ceiling $ sqrt $ fromInteger n
          rows = splitEvery (fromInteger p) $ toList xs
          columns = transpose rows
          vs = or <$> rows
          us = or <$> columns
       in productEncoding vs && productEncoding us &&
          and (imap (\j r -> and $
                imap (\i x -> (x ==> us !! i) && (x ==> vs !! j)) r)
               rows)
  where
    splitEvery n = takeWhile (not . null) . map (take n) . iterate (drop n)