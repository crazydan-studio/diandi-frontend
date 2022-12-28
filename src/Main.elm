module Main exposing (main)

import Browser
import Model exposing (Flags, RootModel)
import Msg exposing (..)
import View


main : Program Flags RootModel RootMsg
main =
    -- https://guide.elm-lang.org/webapps/navigation.html
    Browser.application
        { init = Model.init
        , view = View.create
        , update = Model.update
        , subscriptions = Model.sub
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }
