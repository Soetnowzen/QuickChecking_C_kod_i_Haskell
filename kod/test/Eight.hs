{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}

module Main where

import Data.Char
import Data.Monoid ((<>))
import Foreign.C.Types
import Test.QuickCheck
import qualified Language.C.Inline as C
import System.Random

C.include "linked_list.c"

--C.context (C.baseCtx <> C.funCtx)

--newtype Node_t = Int Node_t | Null
data Node_t = Nil | Cons Int Node_t

instance Random Node_t where
  randomR = randomR_Node_t
  random  = random_Node_t

randomR_Node_t :: RandomGen g => (a, a) -> g -> (a, g)
randomR_Node_t (fst, snd) gen = _

random_Node_t :: RandomGen g => g -> (a, g)
random_Node_t = _

instance Arbitrary Node_t where
  arbitrary = arbitraryNode_t --choose (Nil, Cons arbitrary arbitrary)
  --shrink    = shrinkIntegral

arbitraryNode_t :: Gen Node_t
arbitraryNode_t = frequency [(1, Nil), (3, Cons arbitrarySizedIntegral _)]

--cReverse :: Node_t -> Node_t
--cReverse node = [C.pure| node_t*{ reverse( $(node_t* node) ) } |] :: Node_t


--prop_reverse :: Node_t -> Bool
--prop_reverse list = list == cReverse $ cReverse list

{-
run :: IO CInt
run = [C.block| int{
    node_t d = {'d', 0};
    node_t c = {'c', &d};
    node_t b = {'b', &c};
    node_t a = {'a', &b};

    node_t* root = &a;
    print_list(root);
    root = reverse(root);
    print_list(root);
  
    return 0;
  } |]
-}

--return []
--runTests = $quickCheckAll

main :: IO ()
--main = runTests >>= print
main = print "Hello World!"
--main = run >> print "Done!"
--main = quickCheck prop_reverse
