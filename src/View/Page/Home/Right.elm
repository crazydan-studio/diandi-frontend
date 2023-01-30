module View.Page.Home.Right exposing (view)

import Element exposing (..)
import I18n.Lang exposing (langEnd)
import Model
import Msg
import View.I18n.Home as I18n
import View.Style.Base as BaseStyle


view : Model.State -> Element Msg.Msg
view ({ app, widgets } as state) =
    let
        i18nText =
            I18n.text app.lang
    in
    column
        [ width fill
        , height fill
        , padding BaseStyle.spacing
        ]
        [ paragraph
            [ centerX
            , centerY
            ]
            [ ("这里是主题详情展示页，默认显示当前分类的信息" :: langEnd)
                |> i18nText
            ]
        ]
