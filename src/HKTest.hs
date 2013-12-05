{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE RecordWildCards    #-}

module HKTest where

import           Control.Monad
import           Data.Data
import qualified Data.Text                       as T
import qualified Happstack.Server                as H
import           System.Console.CmdArgs.Implicit ((&=))
import qualified System.Console.CmdArgs.Implicit as I
import           Text.Blaze.Html5                ((!))
import qualified Text.Blaze.Html5                as Html
import qualified Text.Blaze.Html5.Attributes     as Attr

main :: IO ()
main = do
  config <- I.cmdArgs aConfig
  H.simpleHTTP (hConf config) myApp

myApp :: H.ServerPart H.Response
myApp = msum
  [ H.dir "echo" echo
  ]

template :: T.Text -> Html.Html -> H.Response
template title body = H.toResponse $
  Html.html $ do
    Html.head $ Html.title (Html.toHtml title)
    Html.body $ do
      body
      Html.p $ Html.a ! Attr.href "/" $ "back home"

echo :: H.ServerPart H.Response
echo =
  H.path $ \msg ->
    H.ok $ template "echo" $ do
      Html.p $ "echo says: " >> Html.toHtml (msg :: String)
      Html.p "Change the url to echo something else."

-- Config
--------------------------------------------------------------------------------

data Config =
  Config { port :: Int, timeout :: Int } deriving ( Show, Eq, Data, Typeable )

hConf :: Config -> H.Conf
hConf (Config {..}) = H.nullConf { H.timeout = timeout, H.port = port }

aConfig :: Config
aConfig =
  Config { port    = 8000  &= I.help "Port number"
                           &= I.typ "INT"
         , timeout = 30    &= I.help "Timeout"
                           &= I.typ "SECONDS"
         }
    &= I.summary "HKTest server"
    &= I.program "server"
