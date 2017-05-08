module Main where

import DDMin
import Test.QuickCheck

prop_ :: Eq a => [a] -> Bool
prop_ = _

main :: IO ()
main = quickCheck prop_
