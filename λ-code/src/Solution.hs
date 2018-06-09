module Solution
  ( File(..)
  , FileType(..)
  , Hashable(..)
  , ControlSum(..)
  ) where

import Data.Char (ord)
import System.IO

data File = File
  { handle :: IO Handle
  , check_sum :: IO Int
  , strategy :: File -> IO Int
  }

class FileType t where
  create_file :: String -> t
  set_strategy :: t -> (t -> IO Int) -> IO t

instance FileType File where
  set_strategy file strategy_fun =
    return $ File (handle file) (strategy_fun file) strategy_fun
  create_file path =
    File
      (openFile path ReadMode)
      (return (-1) :: IO Int)
      (\x -> return (-1) :: IO Int)

class Hashable t where
  calculate_control_sum :: t -> IO Int

instance Hashable File where
  calculate_control_sum file = strategy file file

class ControlSum t where
  equals :: t -> Int -> IO Bool
  equals_ :: t -> t -> IO Bool

instance ControlSum File where
  equals file sum = do
    csum <- calculate_control_sum file
    return $ csum == sum
  equals_ f1 f2 = do
    csum1 <- calculate_control_sum f1
    csum2 <- calculate_control_sum f2
    return $ csum1 == csum2
