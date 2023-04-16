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
import Element.Background as Background
import Element.Events exposing (..)
import Element.Font as Font
import Html
import Html.Attributes as HtmlAttr
import I18n.Element exposing (textWith)
import I18n.I18n exposing (langTextEnd)
import Json.Decode as Json
import Material.Button as Button
import Material.Card as Card
import Material.IconButton as IconButton
import Material.Theme as Theme
import Material.Typography as Typography
import Model
import Model.Operation.Deletion as Deletion
import Model.TopicCard as TopicCard exposing (TopicCard)
import Msg
import View.I18n.Home as I18n
import View.Page as Page
import Widget.Loading as Loading
import Widget.MdcFontIcon as MdcFontIcon


view :
    Model.State
    -> TopicCard
    -> Element Msg.Msg
view { theme, widgets, withI18nElement } { config, topic, deletion } =
    let
        i18nText =
            withI18nElement I18n.text
    in
    column
        ([ class "topic-card"
         , class "size-fit"
         , alignTop
         ]
            ++ (case deletion of
                    Deletion.DeleteDoing ->
                        [ inFront
                            (el
                                [ width fill
                                , height fill
                                , Background.color theme.layerBackgroundColor
                                ]
                                (row
                                    [ centerX
                                    , centerY
                                    , Font.size 16
                                    , Font.color theme.primaryWhiteBackgroundColor
                                    ]
                                    [ Loading.ball { width = 64, height = 64 }
                                    , paragraph []
                                        [ ("数据正在删除中，请稍等片刻 ..." :: langTextEnd)
                                            |> i18nText
                                        ]
                                    ]
                                )
                            )
                        ]

                    Deletion.DeleteDone ->
                        [ class "delete-zoom"

                        -- 动画结束后从列表中移除
                        , on "animationend"
                            (Json.succeed
                                (Msg.TopicCardMsg
                                    topic.id
                                    (TopicCard.Delete Deletion.DeleteDone)
                                )
                            )
                        ]

                    _ ->
                        []
               )
        )
        [ html <|
            Card.card
                (Card.config
                    |> Card.setAttributes
                        [ HtmlAttr.style "width" "100%"
                        ]
                )
                { blocks =
                    ( Card.block <|
                        Html.div
                            [ HtmlAttr.style "padding" "1rem" ]
                            [ Html.h2
                                [ Typography.headline6
                                , HtmlAttr.style "white-space" "pre-wrap"
                                ]
                                [ Html.text (topic.title |> Maybe.withDefault "无标题") ]
                            , Html.h3
                                [ Typography.subtitle2
                                , Theme.textSecondaryOnBackground
                                , HtmlAttr.style "margin" "0"
                                ]
                                [ Html.text "@2023-04-12 23:12:36" ]
                            ]
                    , (Card.block <|
                        Html.div
                            [ Typography.body2
                            , Theme.textSecondaryOnBackground
                            , HtmlAttr.style "padding" "0 1rem 0.5rem 1rem"
                            , HtmlAttr.style "white-space" "pre-wrap"
                            , HtmlAttr.style "overflow-y" "auto"
                            , HtmlAttr.style "max-height"
                                (if config.expanded then
                                    "100%"

                                 else
                                    "144px"
                                )
                            ]
                            [ Html.text topic.content
                            ]
                      )
                        :: (case deletion of
                                Deletion.DeleteError e ->
                                    [ Card.block <|
                                        Html.div
                                            [ Typography.body2
                                            , Theme.error
                                            , HtmlAttr.style "padding" "0 1rem 0.5rem 1rem"
                                            , HtmlAttr.style "white-space" "pre-wrap"
                                            ]
                                            [ Html.text ("* " ++ "删除失败 - ")
                                            ]
                                    ]

                                -- paragraph
                                --     [ Font.color (Color.toRgbColor Color.Red900)
                                --     ]
                                --     [ text "* "
                                --     , "删除失败 - " :: langTextEnd |> i18nText
                                --     , textWith e
                                --     ]
                                _ ->
                                    []
                           )
                    )
                , actions =
                    Just <|
                        Card.actions
                            { buttons =
                                topic.tags
                                    |> List.map
                                        (\tag ->
                                            Card.button
                                                (Button.config
                                                    |> Button.setOnClick Msg.NoOp
                                                )
                                                ("#" ++ tag)
                                        )
                            , icons =
                                [ Card.icon
                                    (IconButton.config
                                        |> IconButton.setOnClick
                                            (Msg.TopicCardMsg
                                                topic.id
                                                (TopicCard.Delete Deletion.DeleteDoing)
                                            )
                                        |> IconButton.setLabel (Just "Delete Topic")
                                    )
                                    (IconButton.icon MdcFontIcon.delete)
                                , Card.icon
                                    (IconButton.config
                                        |> IconButton.setOnClick
                                            (Msg.batch
                                                [ Msg.EditTopicPending topic.id
                                                , Msg.ShowPageLayer Page.EditTopicLayer
                                                ]
                                            )
                                        |> IconButton.setLabel (Just "Edit Topic")
                                    )
                                    (IconButton.icon MdcFontIcon.edit)
                                , Card.icon
                                    (IconButton.config
                                        |> IconButton.setOnClick
                                            (Msg.TopicCardMsg topic.id
                                                (TopicCard.Expand
                                                    (not config.expanded)
                                                )
                                            )
                                        |> IconButton.setLabel
                                            (Just
                                                (if config.expanded then
                                                    "Collapse"

                                                 else
                                                    "Expand"
                                                )
                                            )
                                    )
                                    (IconButton.icon
                                        (if config.expanded then
                                            MdcFontIcon.expandLess

                                         else
                                            MdcFontIcon.expandMore
                                        )
                                    )
                                ]
                            }
                }
        ]
