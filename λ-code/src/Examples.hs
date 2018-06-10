module Examples
  ( exampleStrategy
  ) where

import           Data.Char (ord)
import           Solution
import           System.IO

exampleStrategy :: File -> IO Int
exampleStrategy file = do
  content <- hGetContents =<< handle file
  return $ (sum . map ord) content
