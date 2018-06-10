module Main where

import           Control.Monad.IO.Class
import           Examples
import           Graphics.UI.Gtk
import           Solution

checkSum :: String -> String -> IO Bool
checkSum p1 p2 = do
  let f1 = create_file p1
  f1_s <- set_strategy f1 exampleStrategy
  let f2 = create_file p2
  f2_s <- set_strategy f2 exampleStrategy
  equals_ f1_s f2_s

calcSumHandler :: FileChooser -> Entry -> IO ()
calcSumHandler choose_file result = do
  path <- fileChooserGetFilename choose_file
  file <-
    case path of
      Just x -> return $ create_file x
  file_2 <- set_strategy file exampleStrategy
  checkSum_res <- calculate_control_sum file_2
  entrySetText result $ show checkSum_res

checkSumHandler :: FileChooser -> FileChooser -> Entry -> IO ()
checkSumHandler choose_file_1 choose_file_2 result = do
  path_1 <- fileChooserGetFilename choose_file_1
  file_1 <-
    case path_1 of
      Just x -> return $ create_file x
  file_1_2 <- set_strategy file_1 exampleStrategy
  path_2 <- fileChooserGetFilename choose_file_2
  file_2 <-
    case path_2 of
      Just x -> return $ create_file x
  file_2_2 <- set_strategy file_2 exampleStrategy
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
