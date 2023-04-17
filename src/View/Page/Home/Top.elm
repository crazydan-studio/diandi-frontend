module View.Page.Home.Top exposing (..)

import Element exposing (..)
import Html exposing (Html)
import Html.Attributes as HtmlAttr
import Html.Events as HtmlEvent
import I18n.I18n exposing (langTextEnd)
import Json.Decode as Decode
import Material.Icons.Outlined as Outlined
import Material.Icons.Types exposing (Coloring(..))
import Model
import Msg
import View.I18n.Home as I18n


view : Model.State -> Html Msg.Msg
view ({ app, withI18nElement } as state) =
    Html.nav
        [ HtmlAttr.class "z-10 w-full bg-white shadow-md dark:bg-gray-800"
        ]
        [ Html.div
            [ HtmlAttr.class "flex items-center px-6 py-2"
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
                        [ HtmlAttr.class "w-48 py-1 pl-10 pr-4 transition duration-300 ease-in-out text-gray-500 placeholder-gray-600 bg-white border-transparent border-b border-gray-600 dark:placeholder-gray-300 dark:focus:border-gray-300 dark:bg-gray-800 dark:text-gray-300 focus:outline-none focus:border-gray-600"
                        , HtmlAttr.placeholder "请输入关键字查询 ..."
                        , HtmlAttr.type_ "text"
                        , HtmlAttr.value (app.topicSearchingText |> Maybe.withDefault "")
                        , HtmlEvent.onInput Msg.SearchTopicInputing
                        , HtmlEvent.on "keyup"
                            (Decode.field "key" Decode.string
                                |> Decode.andThen
                                    (\key ->
                                        if key == "Enter" then
                                            Decode.succeed Msg.SearchTopic

                                        else
                                            Decode.fail "Not the enter key"
                                    )
                            )
                        ]
                        []
                    ]
                ]
            , Html.div
                [ HtmlAttr.class "flex"
                ]
                [ Html.a
                    [ HtmlAttr.class "mx-2 text-gray-600 cursor-pointer transition-colors duration-300 transform dark:text-gray-300 hover:text-gray-500 dark:hover:text-gray-300"
                    ]
                    [ Outlined.settings 24 Inherit ]
                ]
            ]
        ]
