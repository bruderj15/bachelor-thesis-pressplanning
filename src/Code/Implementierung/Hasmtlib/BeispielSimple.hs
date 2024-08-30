module Example.Foo where

import Language.Hasmtlib
import Control.Monad (replicateM)

data Bar a = Bar
  { length :: a
  , height :: a }
  deriving (Generic)
instance Variable a => Variable (Bar a)

barLength :: [Bar (Expr RealSort)] -> Expr BoolSort
barLength = all (\(b1,b2) -> ...) . binom
  where
    binom = ...

main :: IO ()
main = do
  result <- solveWith @SMT (solver cvc5) $ do
    setLogic "QF_LRA"
    -- create variables
    bars <- replicateM 10 variable
    -- constraint variables
    assert $ barLength bars
    -- find model for variables
    return foo
  ...
