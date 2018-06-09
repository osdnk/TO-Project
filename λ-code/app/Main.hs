module Main where

import Control.Monad
import Control.Monad.IO.Class
import Data.IORef
import Examples
import Graphics.UI.Gtk
import Graphics.UI.Gtk.Gdk.EventM
import qualified Graphics.UI.Gtk.Gdk.Events as E
import Solution

import Control.Monad.Trans

check_sum :: String -> String -> IO Bool
check_sum p1 p2 = do
  let f1 = create_file p1
  f1_s <- set_strategy f1 example_strategy
  let f2 = create_file p2
  f2_s <- set_strategy f2 example_strategy
  res <- equals_ f1_s f2_s
  return res

calcSumHandler :: FileChooser -> Entry -> IO ()
calcSumHandler choose_file result = do
  path <- fileChooserGetFilename choose_file
  file <-
    case path of
      Just x -> return $ create_file x
  file_2 <- set_strategy file example_strategy
  check_sum <- calculate_control_sum file_2
  entrySetText result $ show check_sum

checkSumHandler :: FileChooser -> FileChooser -> Entry -> IO ()
checkSumHandler choose_file_1 choose_file_2 result = do
  path_1 <- fileChooserGetFilename choose_file_1
  file_1 <-
    case path_1 of
      Just x -> return $ create_file x
  file_1_2 <- set_strategy file_1 example_strategy
  path_2 <- fileChooserGetFilename choose_file_2
  file_2 <-
    case path_2 of
      Just x -> return $ create_file x
  file_2_2 <- set_strategy file_2 example_strategy
  equals_result <- equals_ file_1_2 file_2_2
  entrySetText result $ show equals_result

main :: IO ()
main = do
  initGUI
  builder <- builderNew
  builderAddFromFile builder "GUI.glade"
  let getButton = builderGetObject builder castToButton
  window <- builderGetObject builder castToWindow "mainWindow"
  buttonCalcSum <- getButton "buttonCalcSum"
  buttonCheckSum <- getButton "buttonCheckSum"
  chooseFile1 <- builderGetObject builder castToFileChooser "fileChooser1"
  chooseFile2 <- builderGetObject builder castToFileChooser "fileChooser2"
  entryResult <- builderGetObject builder castToEntry "entryResult"
  widgetShowAll window
  on window deleteEvent $ liftIO mainQuit >> return False
  on buttonCalcSum buttonReleaseEvent $
    tryEvent $ liftIO $ calcSumHandler chooseFile1 entryResult
  on buttonCheckSum buttonReleaseEvent $
    tryEvent $ liftIO $ checkSumHandler chooseFile1 chooseFile2 entryResult
  mainGUI
