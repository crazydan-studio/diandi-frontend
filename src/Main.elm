module Main exposing (main)

import Browser
import Model
import Msg
import View.App


main : Program Model.Config Model.State Msg.Msg
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
