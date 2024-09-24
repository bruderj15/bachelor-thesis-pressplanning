totalWaste :: Num (Expr t) => PressPlan t -> Expr t
totalWaste = sumOf (layers.folded.waste)

step :: (KnownSMTSort t, Num (Expr t)) => Expr t -> Expr t
step x = case sortSing @t of
  SIntSort  -> x - 1
  SRealSort -> x - 0.001
  _         -> x

main :: IO ()
main = do
  disperseOnPresses $ do
    ...
    (res, sol) <- solveMinimized (totalWaste pressPlan) (Just step) Nothing
    ...