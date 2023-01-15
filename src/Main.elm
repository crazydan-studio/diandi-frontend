module Main exposing (main)

import Browser
import Model exposing (Flags)
import Model.Root exposing (RootModel)
import Msg exposing (..)
import View.App


main : Program Flags RootModel RootMsg
main =
    -- https://guide.elm-lang.org/webapps/navigation.html
    Browser.application
        { init = Model.init
        , view = View.App.view
        , update = Model.update
        , subscriptions = Model.sub
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }
