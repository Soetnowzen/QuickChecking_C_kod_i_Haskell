{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}

module Main where

import qualified Data.ByteString as BS
import Data.Monoid ((<>))
import Foreign.C.Types
import qualified Language.C.Inline as C

C.context (C.baseCtx <> C.bsCtx)

-- | Count the number of set bits in a 'BS.ByteString'.
countSetBits :: BS.ByteString -> IO CInt
countSetBits bs = [C.block|
    int {
      int i, bits = 0;
      for (i = 0; i < $bs-len:bs; i++) {
        char ch = $bs-ptr:bs[i];
        bits += (ch * 01001001001ULL & 042104210421ULL) % 017;
      }
      return bits;
    }
  |]

main :: IO ()
main = print "Hello World!"
