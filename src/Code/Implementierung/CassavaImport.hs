data ComponentIn = ComponentIn
  { length   :: !Integer
  , height   :: !Integer
  , count    :: !Integer
  } deriving stock (Generic)
    deriving anyclass (FromRecord, FromNamedRecord, DefaultOrdered)

data ComponentOut = ComponentOut
  { press    :: !Integer
  , layer    :: !Integer
  , position :: !Integer
  , length   :: !Integer
  , height   :: !Integer
  } deriving stock (Generic)
    deriving anyclass (ToRecord, ToNamedRecord, DefaultOrdered)

-- Schedule is the representation for the decoded Solution
fromSchedule :: Schedule -> [ComponentOut]
fromSchedule = ...

main :: IO ()
main = do
  csvOrder <- ByteString.Lazy.readFile "input/order.csv"
  let order = case Csv.decode @ComponentIn Csv.HasHeader csvOrder of
            Left err -> error err
            Right v -> toList v
  ...
  schedules <- disperseProblem order ...
  forM_ schedules
    (\s -> ByteString.Lazy.writeFile (scheduleName s <> ".csv") $
        Csv.encodeDefaultOrderedByName $ fromSchedule s)