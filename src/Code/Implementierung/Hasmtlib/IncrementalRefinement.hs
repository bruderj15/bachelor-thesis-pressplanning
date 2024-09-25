solveMinimized = solveOptimized (<?)
solveMaximized = solveOptimized (>?)

solveOptimized :: (MonadIncrSMT Pipe m, MonadIO m, KnownSMTSort t)
  => (Expr t -> Expr t -> Expr BoolSort) -- optimization comparison
  -> Expr t                              -- term to optimize
  -> Maybe (Expr t -> Expr t)            -- step-size-adjustment
  -> Maybe (Solution -> IO ())           -- access to intermediate results
  -> m (Result, Solution)
solveOptimized op goal mStep mDebug = refine Unsat mempty goal 0
  where
    refine oldRes oldSol target n_pushes = do
      res <- checkSat
      case res of
        Sat   -> do
          sol <- getModel
          case decode sol target of
            Nothing        -> return (Sat, mempty)
            Just targetSol -> do
              case mDebug of
                Nothing    -> pure ()
                Just debug -> liftIO $ debug sol
              push
              let step = fromMaybe id mStep
              assert $ target `op` step (encode targetSol)
              refine res sol target (n_pushes + 1)
        r -> do
          if n_pushes < 1
          then return (r, mempty)
          else case mStep of
            Nothing -> do
              replicateM_ n_pushes pop
              return (oldRes, oldSol)
            Just _ -> do
              pop
              -- make sure the very last step did not skip the optimal result
              opt <- solveOptimized op goal Nothing mDebug
              replicateM_ (n_pushes - 1) pop
              return opt