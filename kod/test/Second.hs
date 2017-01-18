{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}

module Main where

import qualified Language.C.Inline as C
import Test.QuickCheck

C.include "<stdio.h>"

main :: IO ()
main = do
  x <- [C.block| int {
      // Read and sum 5 integers
      int i, sum = 0, tmp;
      for (i = 0; i < 5; i++) {
        scanf("%d", &tmp);
        sum += tmp;
      }
      return sum;
    } |]
  print x
