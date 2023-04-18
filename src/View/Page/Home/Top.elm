module View.Page.Home.Top exposing (..)

import Element exposing (..)
import Html exposing (Html)
import Html.Attributes as HtmlAttr
import Html.Events as HtmlEvent
import I18n.I18n exposing (langTextEnd)
import Material.Icons.Outlined as Outlined
import Material.Icons.Types exposing (Coloring(..))
import Model
import Msg
import View.I18n.Home as I18n
import Widget.Html exposing (onEnter)


view : Model.State -> Html Msg.Msg
view ({ app, themeDark, withI18nHtml } as state) =
    let
        i18nAttr =
            I18n.htmlAttr app.lang
    in
    Html.nav
        [ HtmlAttr.class "z-10 w-full shadow-md bg-white dark:bg-gray-800"
        ]
        [ Html.div
            [ HtmlAttr.class "flex items-center px-4 py-2"
            ]
            [ Html.a
                [ HtmlAttr.href "/"
                ]
                [ Html.img
                    [ HtmlAttr.class "h-10 md:hidden"
                    , HtmlAttr.src "/icon.svg"
                    ]
                    []
                , Html.img
                    [ HtmlAttr.class "h-10 hidden md:inline"
                    , HtmlAttr.src "/logo.svg"
                    ]
                    []
                ]
            , Html.div
                [ HtmlAttr.class "flex-1 flex flex-row justify-center text-gray-600 capitalize dark:text-gray-300"
                ]
                [ Html.div
                    [ HtmlAttr.class "relative"
                    ]
                    [ Html.span
                        [ HtmlAttr.class "absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500 dark:text-gray-300"
                        ]
                        [ Outlined.search 24 Inherit
                        ]
                    , Html.input
                        ([ HtmlAttr.class "w-48 py-1 pl-10 pr-4 transition duration-300 ease-in-out text-gray-500 placeholder-gray-600 bg-white border-transparent border-b border-gray-600 dark:placeholder-gray-300 dark:focus:border-gray-300 dark:bg-gray-800 dark:text-gray-300 focus:outline-none focus:border-gray-600"
                         , HtmlAttr.type_ "text"
                         , HtmlAttr.value (app.topicSearchingText |> Maybe.withDefault "")
                         , HtmlEvent.onInput Msg.SearchTopicInputing
                         , onEnter Msg.SearchTopic
                         ]
                            ++ i18nAttr
                                HtmlAttr.placeholder
                                ("请输入关键字查询 ..." :: langTextEnd)
                        )
                        []
                    ]
                ]
            , Html.div
                [ HtmlAttr.class "flex gap-2"
                ]
                [ Html.span
                    [ HtmlAttr.class "icon-button"
                    , HtmlEvent.onClick (Msg.SwitchToDarkTheme (not themeDark))
                    ]
                    [ if themeDark then
                        Outlined.light_mode 24 Inherit

                      else
                        Outlined.dark_mode 24 Inherit
                    ]
                , Html.span
                    [ HtmlAttr.class "icon-button"
                    ]
                    [ Outlined.menu 24 Inherit ]
                ]
            ]
        ]
