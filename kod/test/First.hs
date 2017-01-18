{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}

module Main where

import qualified Language.C.Inline as C
import Test.QuickCheck

--C.include "<stdio.h>"
C.include "<math.h>"

main :: IO ()
main = do
  x <- [C.exp| double{ cos(1) } |]
  print x

