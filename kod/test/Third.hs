{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}

module Main where

import qualified Language.C.Inline as C
import Foreign.C.Types

C.include "<stdio.h>"

-- | @readAndSum n@ reads @n@ numbers from standard input and returns their sum.
readAndSum :: CInt -> IO CInt
readAndSum n = [C.block| int {
    // Read and sum n integers
   int i, sum = 0, tmp;
   for (i = 0; i < $(int n); i++) {
     scanf("%d", &tmp);
     sum += tmp;
   }
   return sum;
  } |]

main :: IO ()
main = do
  x <- readAndSum 5
  print x
