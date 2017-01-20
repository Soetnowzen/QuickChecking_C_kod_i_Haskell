{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}

module Main where

import Data.Char
import qualified Language.C.Inline as C
import Test.QuickCheck
import Foreign.C.Types

--C.include "<stdio.h>"
C.include "<math.h>"

cAbs :: CInt -> CInt
cAbs i = [C.pure| int{ abs( $(int i) ) } |] :: CInt

-- |-a| = |a|
prop_negateValue :: CInt -> Bool
prop_negateValue a = cAbs a == cAbs (-a)

-- |ab| = |a||b|
prop_products :: CInt -> CInt -> Bool
prop_products a b = cAbs (a * b) == (cAbs a) * (cAbs b)

-- |a / b| = |a| / |b|
--prop_quotients :: CInt -> CInt -> Bool
--prop_quotients a b = cAbs (a / b) == (cAbs a) / (cAbs b)

prop_powers :: CInt -> CInt -> Bool
prop_powers a n = cAbs (a^n) == (cAbs a)^n

prop_triangleInequality :: CInt -> CInt -> Bool
prop_triangleInequality a b = cAbs (a + b) <= (cAbs a + cAbs b)

prop_alternateTriangleInequality :: CInt -> CInt -> Bool
prop_alternateTriangleInequality a b = cAbs (a - b) >= (cAbs a - cAbs b)

instance Arbitrary CInt where
  arbitrary = arbitrarySizedIntegral
  shrink    = shrinkIntegral

--instance Arbitrary Char where
--  arbitrary     = choose ('\32', '\128')
--  coarbitrary c = variant (ord c `rem` 4)

-- A thin monadic skin layer
getList :: IO [Char]
getList = fmap take5 getContents

-- The actual worker
take5 :: [Char] -> [Char]
take5 = take 5 . filter (`elem` ['a'..'e'])

return []
runTests = $quickCheckAll

main :: IO ()
--main = quickCheck ((\s -> s == s) :: [Char] -> Bool)
--main = quickCheck ((\s -> (reverse.reverse) s == s) :: [Char] -> Bool)
--main = quickCheck (\s -> length (take5 s) <= 5)
--main = quickCheck (\s -> all (`elem` ['a'..'e']) (take5 s))
main = runTests >>= print
