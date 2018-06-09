module Main where

import Solution

main :: IO ()
main = do
  file <- create_file "test_file.txt"
  file2 <- return $ set_strategy file example_strategy
  file_sum <- check_sum file2
  print file_sum
  putStrLn "succes"
