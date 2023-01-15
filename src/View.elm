module View exposing (view)

import Browser
import Element exposing (Element, fill, height, width)
import Element.Font as Font
import Model.Root exposing (RootModel)
import Msg exposing (RootMsg)
import Theme.StyleSheet
import Theme.Theme
import View.Blank
import View.Forbidden
import View.Home
import View.Loading
import View.Login
import View.NotFound
import View.Type as ViewType


view : RootModel -> Browser.Document RootMsg
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
        ViewType.Login ->
            model.title ++ " - " ++ "用户登录"

        ViewType.NotFound ->
            model.title ++ " - " ++ "页面不存在"

        ViewType.Forbidden ->
            model.title ++ " - " ++ "无操作权限"

        ViewType.Loading ->
            model.title ++ " - " ++ "页面加载中..."

        _ ->
            model.description


page : RootModel -> Element RootMsg
page model =
    case model.currentPage of
        ViewType.Login ->
            View.Login.view model

        ViewType.NotFound ->
            View.NotFound.view model

        ViewType.Forbidden ->
            View.Forbidden.view model

        ViewType.Loading ->
            View.Loading.view model

        ViewType.Blank ->
            View.Blank.view model

        ViewType.Home ->
            View.Home.view model
