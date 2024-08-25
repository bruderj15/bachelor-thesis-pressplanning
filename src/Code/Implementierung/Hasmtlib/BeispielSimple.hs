module Example.Foo where

import Language.Hasmtlib
import GHC.Generics

-- a custom data-type marshalled to a solver
data Foo a = Foo a a deriving (Show, Generic)
instance Codec a => Codec (Foo a)
instance Variable a => Variable (Foo a)

main :: IO ()
main = do
  result <- solveWith @SMT (solver cvc5) $ do
    -- set logic for solver to use
    setLogic "QF_LIA"

    -- construct a Foo with variables
    foo@(Foo l r) :: Foo (Expr IntSort) <- variable

    -- constrain foo
    assert $ l === r + r
    assert $ r === 42

    return foo

  print result

-- Prints: (Sat,Just (Foo 84 42))