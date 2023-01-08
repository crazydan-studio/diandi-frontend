module Page.Home exposing (create)

import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Model.ColorPalette
import Model.Root exposing (RootModel)
import Model.User
import Msg exposing (RootMsg)
import Page.Topic.ListView
import Style.Color
import Style.Home
import Style.Html


create : RootModel -> Element RootMsg
create model =
    column
        [ width fill
        , height fill
        ]
        [ row
            Style.Home.topBar
            [ image
                Style.Home.logoInTopBar
                { src = "/logo.svg", description = "" }
            , el
                Style.Home.userAvatarInTopBar
                (text (userName model.me))
            ]
        , row
            [ Style.Html.style "width" "70%"
            , height fill
            , Border.solid
            , Border.color (rgb255 223 225 230)
            , Border.widthEach
                { top = 0
                , right = 1
                , bottom = 0
                , left = 1
                }

            -- for child scrollbar: https://github.com/mdgriffith/elm-ui/issues/149#issuecomment-582229271
            , clip
            , centerX
            ]
            [ column
                [ width (px 256)
                , height fill
                , Border.solid
                , Border.color (rgb255 223 225 230)
                , Border.widthEach
                    { top = 0
                    , right = 1
                    , bottom = 0
                    , left = 0
                    }
                ]
                []
            , column
                [ width fill
                , height fill
                ]
                [ column
                    [ width fill
                    , height shrink
                    , Border.solid
                    , Border.color (rgb255 223 225 230)
                    , Border.widthEach
                        { top = 0
                        , right = 0
                        , bottom = 1
                        , left = 0
                        }
                    ]
                    [ row
                        [ width fill
                        , height (px 80)
                        ]
                        [ el
                            [ width fill
                            , height fill
                            , padding 8
                            ]
                            (text "输入点什么...")
                        , column
                            (Style.Color.fromPalette Model.ColorPalette.Pink600
                                ++ [ width (px 64)
                                   , height fill
                                   , Font.size 20
                                   ]
                            )
                            [ el
                                [ centerX
                                , centerY
                                ]
                                (text "添加")
                            ]
                        ]
                    ]
                , el
                    [ width fill
                    , height fill
                    , scrollbarY
                    ]
                    (Page.Topic.ListView.create model)
                ]
            ]
        ]


userName : Model.User.User -> String
userName user =
    case user of
        Model.User.None ->
            "匿名"

        Model.User.User u ->
            u.name
