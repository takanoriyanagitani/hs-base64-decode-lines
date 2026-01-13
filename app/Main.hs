module Main (main) where

import Data.ByteString as B
import Data.ByteString.Base64 (decode)
import qualified Data.Text as T
import qualified Data.Text.Encoding as TE
import qualified Data.Text.IO as TIO
import System.IO (isEOF)

newtype IsEOF = IsEOF Bool

handleTxt :: Either String T.Text -> IO ()
handleTxt (Left err) = putStrLn err
handleTxt (Right txt) = do
    TIO.putStr txt
    eof :: Bool <- isEOF
    processInput (IsEOF eof)

b64line2txt :: B.ByteString -> Either String T.Text
b64line2txt bline = do
    decoded :: B.ByteString <- decode bline
    let t :: T.Text = TE.decodeUtf8 decoded
    return t

processInput :: IsEOF -> IO ()
processInput (IsEOF True) = return ()
processInput (IsEOF False) = do
    bline :: B.ByteString <- B.getLine
    let utf8str :: Either String T.Text = b64line2txt bline
    handleTxt utf8str

main :: IO ()
main = do
    eof :: Bool <- isEOF
    processInput (IsEOF eof)
