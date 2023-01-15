module View.Page.RemoteData exposing (view)

import Element exposing (..)
import Element.Font as Font
import Model.Remote.Data as RemoteData
import Theme.Theme


view : Theme.Theme.Theme -> (a -> Element msg) -> RemoteData.Status a -> Element msg
view theme dataView dataStatus =
    case dataStatus of
        RemoteData.LoadWaiting ->
            errorView theme "数据未加载"

        RemoteData.Loading ->
            errorView theme "数据加载中，请稍候..."

        RemoteData.Loaded data ->
            dataView data

        RemoteData.LoadingError error ->
            errorView theme error



-- -------------------------------------------------


errorView : Theme.Theme.Theme -> String -> Element msg
errorView theme error =
    column
        [ width fill
        , height fill
        , paddingXY 8 16
        ]
        [ paragraph
            ([ centerX
             , Font.center
             ]
                ++ Theme.Theme.placeholderFont theme
            )
            [ text error ]
        ]
