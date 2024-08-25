class    KnownSMTSort (t :: SMTSort) where sortSing :: SSMTSort t
instance KnownSMTSort IntSort        where sortSing = SIntSort
instance KnownSMTSort RealSort       where sortSing = SRealSort
instance KnownSMTSort BoolSort       where sortSing = SBoolSort
...