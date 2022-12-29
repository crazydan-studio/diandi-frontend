module Page.Home exposing (create)

import Element exposing (..)
import Model.Root exposing (RootModel)
import Model.User
import Msg exposing (RootMsg)


create : RootModel -> Element RootMsg
create model =
    column
        [ width fill
        , height fill
        ]
        [ text
            ("Home Page: "
                ++ (case model.me of
                        Model.User.None ->
                            "Anonymous"

                        Model.User.User u ->
                            u.name ++ "(" ++ Maybe.withDefault "" u.email ++ ")"
                   )
            )
        ]
