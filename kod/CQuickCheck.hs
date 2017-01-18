{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}

module CQuickCheck where

import qualified Language.C.Inline as C

--import QuickCheck

C.include "<math.h>"

main :: IO ()
main = do
	x <- [C.exp| double{ cos(1) } |]
	print x