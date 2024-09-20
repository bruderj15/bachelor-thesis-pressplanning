solveMinimized = solveOptimized (<?)
solveMaximized = solveOptimized (>?)

solveOptimized :: (MonadIncrSMT Pipe m, MonadIO m, KnownSMTSort t)
  => (Expr t -> Expr t -> Expr BoolSort) -- optimization comparison
  -> Expr t                              -- term to optimize
  -> Maybe (Expr t -> Expr t)            -- step-size-adjustment
  -> m (Result, Solution)
solveOptimized op goal mStep = refine Unsat mempty goal
  where
    refine oldRes oldSol target = do
      res <- checkSat
      case res of
        Sat   -> do
          sol <- getModel
          case decode sol target of
            Nothing        -> return (Sat, mempty)
            Just targetSol -> do
              push
              let step = fromMaybe id mStep
              assert $ target `op` step (encode targetSol)
              refine res sol target
        _ -> do
          pop
          case mStep of
            Nothing -> return (oldRes, oldSol)
            Just _  -> solveOptimized op goal Nothing