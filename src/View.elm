module View exposing (create)

import Browser
import Element exposing (Element, fill, height, width)
import Element.Font as Font
import Html
import Html.Attributes as HtmlAttr
import Model.Root exposing (RootModel)
import Msg exposing (RootMsg)
import Page.Blank
import Page.Forbidden
import Page.Home
import Page.Loading
import Page.Login
import Page.NotFound
import Page.Type as PageType


create : RootModel -> Browser.Document RootMsg
create model =
    { title = title model
    , body =
        [ Element.layout
            [ Font.family
                [ Font.serif
                ]
            , Font.size 14
            , width fill
            , height fill
            ]
            (page model)
        , Html.div
            [ HtmlAttr.id "_page_is_ready_"
            ]
            []
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


page : RootModel -> Element RootMsg
page model =
    case model.currentPage of
        PageType.Login ->
            Page.Login.create model

        PageType.NotFound ->
            Page.NotFound.create model

        PageType.Forbidden ->
            Page.Forbidden.create model

        PageType.Loading ->
            Page.Loading.create model

        PageType.Blank ->
            Page.Blank.create model

        PageType.Home ->
            Page.Home.create model
