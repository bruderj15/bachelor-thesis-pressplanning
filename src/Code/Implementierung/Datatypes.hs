data Component a = Component
  { _cId        :: Integer
  , _compLength :: a
  , _compHeight :: a
  } deriving stock (Show, Eq, Ord, Functor, Foldable, Traversable, Generic)
    deriving anyclass (Codec)
$(makeLenses ''Component)

data Layer a b = Layer
  { _lId         :: Integer
  , _layerLength :: a
  , _layerHeight :: a
  , _layerEmpty  :: b
  , _waste       :: a
  } deriving stock (Show, Eq, Ord, Generic)
    deriving anyclass (Codec)
$(makeLenses ''Layer)

data StaticPress a = StaticPress
  { _pId            :: Integer
  , _pressName      :: String
  , _pressMinLength :: a
  , _pressMaxLength :: a
  , _pressMinHeight :: a
  , _pressMaxHeight :: a
  } deriving stock (Show, Eq, Ord, Functor, Foldable, Traversable, Generic)
    deriving anyclass (Codec)
$(makeLenses ''StaticPress)

data Press a b = Press
  { _press       :: StaticPress a
  , _pressLength :: a
  , _pressHeight :: a
  , _pressLayers :: [Layer a b]
  } deriving stock (Show, Eq, Ord, Generic)
    deriving anyclass (Codec)
$(makeLenses ''Press)
