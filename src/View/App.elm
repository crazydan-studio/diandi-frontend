module View.App exposing (view)

import Browser
import Element exposing (Element, fill, height, width)
import Element.Font as Font
import Model.Root exposing (RootModel)
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


view : RootModel -> Browser.Document Msg.Msg
view ({ theme } as model) =
    { title = title model
    , body =
        [ Element.layout
            [ width fill
            , height fill
            , Font.family
                [ Font.typeface "Roboto"
                , Font.sansSerif
                ]
            , Font.size theme.primaryFontSize
            , Font.color
                (Theme.Theme.primaryFontColor theme)
            ]
            (page model)
        , Theme.StyleSheet.create theme
        ]
    }


title : RootModel -> String
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


page : RootModel -> Element Msg.Msg
page model =
    case model.currentPage of
        PageType.Login ->
            View.Page.Login.view model

        PageType.NotFound ->
            View.Page.NotFound.view model

        PageType.Forbidden ->
            View.Page.Forbidden.view model

        PageType.Loading ->
            View.Page.Loading.view model

        PageType.Blank ->
            View.Page.Blank.view model

        PageType.Home ->
            View.Page.Home.view model
