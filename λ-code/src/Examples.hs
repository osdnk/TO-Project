module Examples
  ( example_strategy
  ) where

import Data.Char (ord)
import Solution
import System.IO

example_strategy :: File -> IO Int
example_strategy file = do
  content <- hGetContents =<< handle file
  return $ (sum . map ord) content
