module View.App exposing (view)

import Browser
import Element exposing (Element, fill, height, width)
import Element.Font as Font
import Model
import Model.App
import Msg
import Theme.StyleSheet
import Theme.Theme
import View.Page as PageType
import View.Page.Blank
import View.Page.Forbidden
import View.Page.Home
import View.Page.Loading
import View.Page.Login
import View.Page.NotFound


view : Model.State -> Browser.Document Msg.Msg
view ({ app } as state) =
    { title = title app
    , body =
        [ Element.layout
            [ width fill
            , height fill
            , Font.family
                [ Font.typeface "Roboto"
                , Font.sansSerif
                ]
            , Font.size app.theme.primaryFontSize
            , Font.color
                (Theme.Theme.primaryFontColor app.theme)
            ]
            (page state)
        , Theme.StyleSheet.create app.theme
        ]
    }


title : Model.App.State -> String
title model =
    case model.currentPage of
        PageType.Login ->
            model.title ++ " - " ++ "用户登录"

        PageType.NotFound ->
            model.title ++ " - " ++ "页面不存在"

        PageType.Forbidden ->
            model.title ++ " - " ++ "无操作权限"

        PageType.Loading ->
            model.title ++ " - " ++ "页面加载中..."

        _ ->
            model.description


page : Model.State -> Element Msg.Msg
page ({ app } as state) =
    case app.currentPage of
        PageType.Login ->
            View.Page.Login.view state

        PageType.NotFound ->
            View.Page.NotFound.view state

        PageType.Forbidden ->
            View.Page.Forbidden.view state

        PageType.Loading ->
            View.Page.Loading.view state

        PageType.Blank ->
            View.Page.Blank.view state

        PageType.Home ->
            View.Page.Home.view state
