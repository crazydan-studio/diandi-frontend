{-
   点滴(DianDi) - 聚沙成塔，集腋成裘
   Copyright (C) 2022 by Crazydan Studio (https://studio.crazydan.org/)

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
-}


module View.Page.Topic.Card exposing (view)

import Element exposing (..)
import Model
import Model.Topic exposing (Topic)
import Msg
import Random
import Widget.Html exposing (class)


view :
    Model.State
    -> Topic
    -> Random.Seed
    -> Element Msg.Msg
view ({ app, theme } as state) topic randomSeed =
    let
        ( ( cardRotateDeg, pushpinPosition ), _ ) =
            Random.step (Random.pair (Random.float 0 1) (Random.float 0 1)) randomSeed
    in
    el
        [ alignTop
        , inFront
            (image
                [ width shrink
                , height (px 32)
                , alignTop
                , moveRight (pushpinPosition * 100 + 20)
                , pointer
                ]
                { src = "/img/pushpin.svg", description = "", onLoad = Nothing }
            )
        ]
        (column
            [ width (px 240)
            , height (px 172)
            , padding 24
            , class "card"
            , clip
            , htmlStyleAttribute
                [ ( "transform"
                  , "rotate(" ++ String.fromFloat (cardRotateDeg * 10 - 5) ++ "deg)"
                  )
                ]
            ]
            [ el
                [ width fill
                , height fill
                , scrollbarY
                , pointer
                ]
                (paragraph []
                    [ text topic.content
                    ]
                )
            ]
        )
