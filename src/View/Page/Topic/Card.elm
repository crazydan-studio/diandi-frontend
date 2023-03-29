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
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Transition as Transition
import Model
import Model.Topic exposing (Topic)
import Msg
import View.Style.Base as BaseStyle
import Widget.Html exposing (class, tabindex)
import Widget.Widget.Button as Button
import Widget.Widget.Markdown as Markdown


view :
    Model.State
    -> Topic
    -> Element Msg.Msg
view ({ app, theme, withWidgetContext } as state) topic =
    let
        shadow =
            --   box-shadow: rgba(0, 0, 0, 0.2) 0px 2px 1px -1px, rgba(0, 0, 0, 0.14) 0px 1px 1px 0px, rgba(0, 0, 0, 0.12)0px 1px 3px 0px;
            Border.shadows
                [ { inset = False
                  , offset = ( 0, 2 )
                  , blur = 1
                  , size = -1
                  , color = rgba255 0 0 0 0.2
                  }
                , { inset = False
                  , offset = ( 0, 1 )
                  , blur = 1
                  , size = 0
                  , color = rgba255 0 0 0 0.14
                  }
                , { inset = False
                  , offset = ( 0, 1 )
                  , blur = 3
                  , size = 0
                  , color = rgba255 0 0 0 0.12
                  }
                ]

        hoverShadow =
            -- box-shadow: 0px 2px 4px -1px rgba(0, 0, 0, 0.2), 0px 4px 5px 0px rgba(0, 0, 0, 0.14), 0px 1px 10px 0px rgba(0, 0, 0, 0.12);
            Border.shadows
                [ { inset = False
                  , offset = ( 0, 2 )
                  , blur = 4
                  , size = -1
                  , color = rgba255 0 0 0 0.2
                  }
                , { inset = False
                  , offset = ( 0, 4 )
                  , blur = 5
                  , size = 0
                  , color = rgba255 0 0 0 0.14
                  }
                , { inset = False
                  , offset = ( 0, 1 )
                  , blur = 10
                  , size = 0
                  , color = rgba255 0 0 0 0.12
                  }
                ]
    in
    column
        (theme.primaryWhiteBackground
            ++ [ class "topic-card"
               , class "size-fit"
               , tabindex 1
               , alignTop
               , padding BaseStyle.spacing
               , Border.rounded 4
               , shadow
               , mouseOver [ hoverShadow ]
               , focused [ hoverShadow ]
               , Transition.with
                    [ Transition.property "box-shadow"
                        [ Transition.duration 0.3
                        , Transition.delay 0
                        , Transition.cubic 0.4 0 0.2 1
                        ]
                    ]
               ]
        )
        [ column
            [ width fill
            , padding BaseStyle.spacing
            , spacing BaseStyle.spacing
            ]
            [ el
                [ width fill
                , class "head"
                , Font.size 20
                , Font.weight 400
                , Font.color
                    (topic.title
                        |> Maybe.map
                            (\_ ->
                                theme.primaryFontColor
                            )
                        |> Maybe.withDefault theme.placeholderFontColor
                    )
                , Font.center
                ]
                (text (topic.title |> Maybe.withDefault "无标题"))
            , row
                [ width fill
                , height (shrink |> maximum 144)
                , class "body"
                , Font.size theme.primaryFontSize
                , Font.color (rgba255 0 0 0 0.54)
                ]
                [ el
                    [ width fill
                    , height fill
                    , clip
                    ]
                    (el
                        [ width fill
                        , scrollbarY
                        ]
                        (paragraph []
                            [ withWidgetContext <|
                                Markdown.render
                                    { lineHeight = 20
                                    }
                                    topic.content
                            ]
                        )
                    )
                ]
            ]
        , wrappedRow
            [ width fill
            , class "bottom"
            , spacing (BaseStyle.spacing // 2)
            ]
            (topic.tags
                |> List.map
                    (\tag ->
                        withWidgetContext <|
                            Button.link
                                { attrs =
                                    [ Font.size 13
                                    , paddingXY 8 0
                                    ]
                                , content = text ("#" ++ tag)
                                , onPress = Nothing
                                }
                    )
            )
        ]
