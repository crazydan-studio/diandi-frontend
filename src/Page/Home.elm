module Page.Home exposing (create)

import Element exposing (..)
import Model.Root exposing (RootModel)
import Model.User
import Msg exposing (RootMsg)
import Page.Card.ListView
import Style.Home


create : RootModel -> Element RootMsg
create model =
    column
        [ width fill
        , height fill
        ]
        [ row
            (Style.Home.topBar
                ++ [ width fill
                   ]
            )
            [ image
                [ alignLeft
                , height (px 32)
                ]
                { src = "/logo.svg", description = "" }
            , el
                (Style.Home.userAvatar
                    ++ [ alignRight
                       ]
                )
                (text (userName model.me))
            ]
        , row
            [ width fill
            , height fill

            -- for child scrollbar: https://github.com/mdgriffith/elm-ui/issues/149#issuecomment-582229271
            , clip
            ]
            [ el
                [ width fill
                , height fill
                -- , paddingXY 482 0
                , scrollbarY
                ]
                (Page.Card.ListView.create model)
            ]
        , row
            (Style.Home.bottomBar
                ++ [ width fill
                   ]
            )
            []
        ]


userName : Model.User.User -> String
userName user =
    case user of
        Model.User.None ->
            "匿名"

        Model.User.User u ->
            u.name
