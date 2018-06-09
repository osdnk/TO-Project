module Solution
  (
    File(..)
    , FileType(..)
    , Hashable(..)
    , ControlSum(..)
    , example_strategy
    , create_file
  ) where

import System.IO
import Data.Char (ord)

data File = File {handle :: IO Handle
                 , check_sum :: IO Int
                 , strategy :: File -> IO Int
                 }

class FileType t where
  set_strategy :: t -> (t -> IO Int) -> t
  
class Hashable t where
  calculate_control_sum :: t -> IO Int

class ControlSum t where
  equals :: t -> Int -> IO Bool

instance FileType File where
  set_strategy file strategy_fun = File (handle file) (strategy_fun file) strategy_fun

instance ControlSum File where
  equals file sum = do
    csum <- calculate_control_sum file
    return $ csum == sum

instance Hashable File where
  calculate_control_sum file = (strategy file) file

example_strategy :: File -> IO Int
example_strategy file = do
  content <- hGetContents =<< handle file
  return $ (sum . map ord) content

create_file :: String -> IO File
create_file path = return $ File (openFile path ReadMode) (return (-1) :: IO Int) (\x -> return (-1) :: IO Int) 

