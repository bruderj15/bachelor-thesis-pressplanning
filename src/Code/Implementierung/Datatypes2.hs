data PressPlan t = PressPlan
  { _components :: [Component (Expr t)]
  , _layers     :: [Layer (Expr t) (Expr BoolSort)]
  , _presses    :: [Press (Expr t) (Expr BoolSort)]
  , _inLayer    :: Relation Integer Integer
  } deriving stock (Generic)
$(makeLenses ''PressPlan)
