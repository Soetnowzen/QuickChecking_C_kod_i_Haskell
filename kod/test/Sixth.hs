{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}

module Main where

import qualified Language.C.Inline as C
import Data.Monoid ((<>))
import Foreign.C.Types

--  To use the function pointer anti-quoter, we need the 'C.funCtx' along with
--  the 'C.baseCtx'
C.context (C.baseCtx <> C.funCtx)

ackermann :: CLong -> CLong -> CLong
ackermann m n
  | m == 0 = n + 1
  | m > 0 && n == 0 = ackermann (m-1) 1
  | otherwise = ackermann (m - 1) (ackermann m (n - 1))

main :: IO ()
main = do
  let ackermannIO m n = return $ ackermann m n
  let x = 3
  let y = 4
  z <- [C.exp| long{
      $fun:(long (*ackermannIO)(long, long))($(long x), $(long y))
    } |]
  print z
