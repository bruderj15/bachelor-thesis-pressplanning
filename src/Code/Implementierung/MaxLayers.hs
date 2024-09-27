import ...
import Data.Discrimination (Sorting(..), sort)

maxLayers :: (Num a, Sorting a) => StaticPress a -> [Component a] -> Integer
maxLayers p =
    genericLength
  . takeWhile (<= p^.pressMaxHeight)
  . drop 1
  . scanl (+) 0
  . sort
  . fmap (view compHeight)