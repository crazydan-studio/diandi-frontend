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
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import I18n.Element exposing (textWith)
import I18n.I18n exposing (langTextEnd)
import Json.Decode as Json
import Model
import Model.Operation.Deletion as Deletion
import Model.TopicCard as TopicCard exposing (TopicCard)
import Msg
import View.I18n.Home as I18n
import View.Page as Page
import View.Style.Base as BaseStyle
import Widget.Animation.Transition as Transition
import Widget.Color as Color
import Widget.Icon as Icon
import Widget.Loading as Loading
import Widget.Shadow as Shadow
import Widget.Widget.Button as Button
import Widget.Widget.Markdown as Markdown


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
        (theme.primaryWhiteBackground
            ++ [ class "topic-card"
               , class "size-fit"

               -- 启用获取焦点，以支持设置鼠标选中样式
               , tabindex 1
               , alignTop
               , padding BaseStyle.spacing
               , Border.rounded 4
               , Shadow.normal
               , mouseOver [ Shadow.hover ]
               , focused [ Shadow.hover ]
               , Transition.defaultWith
                    [ "box-shadow"
                    ]
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
        [ column
            [ width fill
            , padding BaseStyle.spacing
            , spacing BaseStyle.spacing
            ]
            [ paragraph
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
                [ text (topic.title |> Maybe.withDefault "无标题") ]
            , row
                ([ width fill
                 , class "body"
                 , Font.size theme.primaryFontSize
                 , Font.color (rgba255 0 0 0 0.54)
                 , Transition.defaultWith
                    [ "max-height"
                    ]
                 ]
                    ++ (if config.expanded then
                            [ styles [ ( "max-height", "100%" ) ] ]

                        else
                            [ height (shrink |> maximum 144) ]
                       )
                )
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
                            [ widgets.with <|
                                Markdown.render
                                    { lineHeight = 20
                                    }
                                    topic.content
                            ]
                        )
                    )
                ]
            ]
        , column
            [ width fill
            , class "bottom"
            ]
            [ row
                [ width fill
                , spacing BaseStyle.spacing
                ]
                [ wrappedRow
                    [ width fill
                    , spacing (BaseStyle.spacing // 2)
                    ]
                    (topic.tags
                        |> List.map
                            (\tag ->
                                widgets.with <|
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
                , row
                    [ alignRight
                    ]
                    [ widgets.with <|
                        Button.link
                            { attrs = [ width shrink ]
                            , content =
                                theme.primaryLinkBtnIcon
                                    { icon = Icon.DeleteOutlined, size = Nothing }
                            , onPress =
                                Just
                                    (Msg.TopicCardMsg
                                        topic.id
                                        (TopicCard.Delete Deletion.DeleteDoing)
                                    )
                            }
                    , widgets.with <|
                        Button.link
                            { attrs = [ width shrink ]
                            , content =
                                theme.primaryLinkBtnIcon
                                    { icon = Icon.EditOutlined, size = Nothing }
                            , onPress =
                                Just
                                    (Msg.batch
                                        [ Msg.EditTopicPending topic.id
                                        , Msg.ShowPageLayer Page.EditTopicLayer
                                        ]
                                    )
                            }
                    , widgets.with <|
                        Button.link
                            { attrs = [ width shrink ]
                            , content =
                                theme.primaryLinkBtnIcon
                                    { icon =
                                        if config.expanded then
                                            Icon.ShrinkOutlined

                                        else
                                            Icon.ArrowsAltOutlined
                                    , size = Nothing
                                    }
                            , onPress =
                                Just
                                    (Msg.TopicCardMsg topic.id
                                        (TopicCard.Expand
                                            (not config.expanded)
                                        )
                                    )
                            }
                    ]
                ]
            , case deletion of
                Deletion.DeleteError e ->
                    paragraph
                        [ Font.color (Color.toRgbColor Color.Red900)
                        ]
                        [ text "* "
                        , "删除失败 - " :: langTextEnd |> i18nText
                        , textWith e
                        ]

                _ ->
                    none
            ]
        ]
