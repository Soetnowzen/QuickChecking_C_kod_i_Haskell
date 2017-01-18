{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}

module Main where

import qualified Language.C.Inline as C
import qualified Data.Vector.Storable as V
import qualified Data.Vector.Storable.Mutable as VM
import Data.Monoid ((<>))
import Foreign.C.Types

-- To use the vecotr anti-quoters, we need the 'C.vecCtx' along with
-- the 'C.baseCtx'.
C.context (C.baseCtx <> C.vecCtx)

sumVec :: VM.IOVector CDouble -> IO CDouble
sumVec vec = [C.block| double {
    double sum = 0;
    int i;
    for (i = 0; i < $vec-len:vec; i++) {
      sum += $vec-ptr:(double *vec)[i];
    }
    return sum;
  } |]

main :: IO ()
main = do
  x <- sumVec =<< V.thaw (V.fromList [1,2,3])
  print x
