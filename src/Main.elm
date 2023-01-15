module Main exposing (main)

import Browser
import Model exposing (Flags)
import Model.Root exposing (RootModel)
import Msg
import View.App


main : Program Flags RootModel Msg.Msg
main =
    -- https://guide.elm-lang.org/webapps/navigation.html
    Browser.application
        { init = Model.init
        , view = View.App.view
        , update = Model.update
        , subscriptions = Model.sub
        , onUrlChange = Msg.UrlChanged
        , onUrlRequest = Msg.LinkClicked
        }
