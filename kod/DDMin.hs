module DDMin
  ( ddMin
  , Result
  ) where

data Result = Pass | Fail | Unresolved
  deriving Eq

-- | A failing test case, split into the `circumstances` that make up this test case
ddMin :: Eq a => [a] -> Int -> ([a] -> Result) -> [a]
ddMin [c]           _       _    = [c]
ddMin circumstances nChunks test = if test circumstances /= Fail
    then circumstances  -- Test should fail on provided circumstances.
    else concat $ ddMin' chunks chunks nChunks test
  where chunks = splitInChunks circumstances nChunks

ddMin' :: Eq a => [[a]] -> [[a]] -> Int -> ([a] -> Result) -> [[a]]
ddMin' []     chunks nChunks test = let size = length chunks
  in if nChunks < size
        then ddMin' chunks chunks (min (2 * nChunks) size) test
        else chunks
ddMin' (c:cs) chunks nChunks test = if test (concat smallerInput) == Fail
    then ddMin' smallerInput smallerInput (max (nChunks - 1) 2) test
    else ddMin' cs chunks nChunks test
  where smallerInput = allChunksExcept chunks c

-- | Combine all chunks into one collection, leaving the specified collection out.
allChunksExcept :: Eq a => [[a]] -> [a] -> [[a]]
allChunksExcept []     _        = []
allChunksExcept (c:cs) excluded = if c == excluded
  then cs
  else c : allChunksExcept cs excluded

-- | Split the provided collection into n chunks. Last chunk may be shorter
-- than others.
splitInChunks :: [a] -> Int -> [[a]]
splitInChunks circumstances n = rightSize circumstances chunkMaxSize []
  where size = length circumstances
        chunkMaxSize = splitInChunks' size (size `div` n)

splitInChunks' :: Int -> Int -> Int
splitInChunks' size chunkMaxSize
  | chunkMaxSize == 0           = 1
  | size `mod` chunkMaxSize > 0 = 1 + chunkMaxSize
  | otherwise                   = chunkMaxSize

-- | Create chunks of the right size
rightSize :: [a] -> Int -> [a] -> [[a]]
rightSize []     _            chunk = [chunk]
rightSize (c:cs) chunkMaxSize chunk = if length chunk == chunkMaxSize
  then (c:chunk) : rightSize cs chunkMaxSize []
  else rightSize cs chunkMaxSize (c:chunk)


