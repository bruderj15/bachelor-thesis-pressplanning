class Semigroup a where
  (<>) :: a -> a -> a

instance Semigroup (List a) where
  (<>) xs ys = append xs ys
