count' :: forall t f. (Functor f, Foldable f, Num (Expr t))
    => Proxy t -> f (Expr BoolSort) -> Expr t
count' _ = sum . fmap (\b -> ite b 1 0)

count :: forall t f. (Functor f, Foldable f, Num (Expr t))
    => f (Expr BoolSort) -> Expr t
count = count' (Proxy @t)

atMost  :: forall t f. (Functor f, Foldable f, Num (Expr t), Orderable (Expr t))
    => Expr t -> f (Expr BoolSort) -> Expr BoolSort
atMost  k = (<=? k) . count

atLeast :: forall t f. (Functor f, Foldable f, Num (Expr t), Orderable (Expr t))
    => Expr t -> f (Expr BoolSort) -> Expr BoolSort
atLeast k = (>=? k) . count

exactly :: forall t f. (Functor f, Foldable f, Num (Expr t), Orderable (Expr t))
    => Expr t -> f (Expr BoolSort) -> Expr BoolSort
exactly k = (=== k) . count
