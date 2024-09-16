runProblem = forall t. (KnownSMTSort t, MonadSMT s m) => ... -> m ()
runProblem ... = do
  ...
  setLogic $ case sortSing @t of
    SIntSort    -> "QF_LIA"
    SRealSort   -> "QF_LRA"
    SBvSort _ _ -> "QF_BV"
    _           -> "ALL"
  ...
  forM_ (problem @t _ _) assert