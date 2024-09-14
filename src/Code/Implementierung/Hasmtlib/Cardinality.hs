count :: forall t f. (Functor f, Foldable f, Num (Expr t))
  => f (Expr BoolSort) -> Expr t
count = sum . fmap (\b -> ite b 1 0)

atMost  :: forall t f. (Functor f, Foldable f, KnownSMTSort t
  , Num (HaskellType t), Ord (HaskellType t))
  => Expr t -> f (Expr BoolSort) -> Expr BoolSort
atMost 0 = nand
atMost 1 = amoSqrt
atMost k = (<=? k) . count

-- Pure product-encoding
amoSqrt :: (Foldable f, Boolean b) => f b -> b
amoSqrt xs
  | length xs < 10 = amoQuad $ toList xs
  | otherwise =
      let n = toInteger $ length xs
          p = ceiling $ sqrt $ fromInteger n
          rows = splitEvery (fromInteger p) $ toList xs
          columns = transpose rows
          vs = or <$> rows
          us = or <$> columns
       in amoSqrt vs && amoSqrt us &&
          and (
            imap
            (\j r -> and $
                imap (\i x -> (x ==> us !! i) && (x ==> vs !! j)) r)
            rows
          )
  where
    splitEvery n = takeWhile (not . null) . map (take n) . iterate (drop n)