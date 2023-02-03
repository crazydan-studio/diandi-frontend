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

import Base64
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Event
import Element.Font as Font
import Element.Input as Input
import I18n.Lang exposing (langEnd)
import Json.Decode as Decode
import Model
import Model.Operation.EditTopic as EditTopic exposing (EditTopic)
import Model.Topic exposing (Topic)
import Msg
import Theme.Theme as Theme exposing (Theme)
import View.I18n.Home as I18n
import View.Style.Base as BaseStyle
import View.Style.Border.Primary as PrimaryBorder
import Widget.Color
import Widget.Dimension as Dimension
import Widget.Html
import Widget.Icon as Icon exposing (Icon)
import Widget.Widget.Button as Button
import Widget.Widget.Markdown as Markdown


view :
    Model.State
    -> Topic
    -> Element Msg.Msg
view ({ app } as state) topic =
    let
        cornerRoundedSize =
            4

        -- 孔洞宽度
        cardHoleWidth =
            bgGridLineSpacing

        -- 孔洞左侧留白大小
        cardHolePaddingLeft =
            4

        -- 打孔区域宽度
        cardHolePaneWidth =
            cardHoleWidth
                + cardHolePaddingLeft
                + (gridLineMoveLeft + 1)
                + holeSeparatorSize

        -- 打孔区域可见区域宽度
        cardHolePaneDisplayWidth =
            cardHolePaneWidth - gridLineMoveLeft - holeSeparatorSize

        -- 格线左移位置
        gridLineMoveLeft =
            8

        -- 主题内容的横向留白大小
        contentPaddingX =
            BaseStyle.spacing2x

        contentPaddingLeft =
            contentPaddingX + gridLineMoveLeft + holeSeparatorSize

        contentPaddingRight =
            contentPaddingX - 2

        contentPaddingY =
            20
    in
    column
        [ id topic.id
        , width fill
        , Background.color (rgb255 255 255 255)
        , Border.rounded cornerRoundedSize
        , paddingEach
            (Dimension.left cardHolePaneDisplayWidth)

        -- box-shadow: 0px 2px 1px -1px rgba(0,0,0,0.2),0px 1px 1px 0px rgba(0,0,0,0.14),0px 1px 3px 0px rgba(0,0,0,0.12);
        , Border.shadows
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

        -- , inFront
        --     (app.editTopic
        --         |> withFocusedEditTopic topic
        --             (\editTopic ->
        --                 el
        --                     [ width fill
        --                     , height fill
        --                     , padding BaseStyle.spacing2x
        --                     , Background.color (rgba255 0 0 0 0.4)
        --                     ]
        --                     (editTopicInput topic editTopic state)
        --             )
        --         |> Maybe.withDefault none
        --     )
        ]
        [ row
            [ width fill
            , height fill
            , Background.color (rgba255 0 0 0 0)
            , Widget.Html.styles
                [ ( "background-image"
                  , "linear-gradient("
                        ++ bgGridLineRgbColor
                        ++ " "
                        ++ String.fromInt bgGridLineSize
                        ++ "px, transparent 0)"
                  )
                , ( "background-size"
                  , "100% "
                        ++ String.fromInt bgGridLineSpacing
                        ++ "px"
                  )
                , ( "background-position"
                  , "0 "
                        ++ String.fromInt contentPaddingY
                        ++ "px"
                  )
                ]
            , inFront
                (el
                    [ width (px cardHolePaneWidth)
                    , height fill
                    , moveLeft (toFloat cardHolePaneDisplayWidth)
                    , paddingEach
                        (Dimension.vertical contentPaddingY)
                    , Border.widthEach
                        (Dimension.right holeSeparatorSize)
                    , Border.solid
                    , Border.color holeSeparatorColor
                    ]
                    (el
                        [ width fill
                        , height fill
                        , Widget.Html.styles
                            [ ( "background-image"
                              , "url(\"" ++ holeSvgImg app.theme ++ "\")"
                              )
                            , ( "background-repeat"
                              , "repeat-y"
                              )
                            , ( "background-size"
                              , String.fromInt cardHoleWidth ++ "px"
                              )
                            , ( "background-position"
                              , String.fromInt cardHolePaddingLeft ++ "px 0"
                              )
                            ]
                        ]
                        none
                    )
                )
            ]
            [ app.editTopic
                |> withFocusedEditTopic topic
                    (\editTopic ->
                        el
                            [ width fill
                            , paddingEach
                                (Dimension.left (contentPaddingLeft - contentPaddingX))
                            ]
                            (el
                                [ width fill
                                , padding BaseStyle.spacing2x
                                , Border.roundEach
                                    { topLeft = 0
                                    , topRight = cornerRoundedSize
                                    , bottomLeft = 0
                                    , bottomRight = cornerRoundedSize
                                    }
                                , Background.color (rgba255 0 0 0 0.4)
                                ]
                                (editTopicInput topic editTopic state)
                            )
                    )
                |> Maybe.withDefault
                    (column
                        [ width fill
                        , paddingEach
                            { top = 0
                            , left = contentPaddingLeft
                            , right = contentPaddingRight
                            , bottom = contentPaddingY
                            }
                        ]
                        [ el
                            [ width fill
                            , height (px contentPaddingY)
                            ]
                            (toolbarView state topic)
                        , contentView state topic
                        ]
                    )
            ]
        ]


withFocusedEditTopic :
    Topic
    -> (EditTopic -> a)
    -> Maybe EditTopic
    -> Maybe a
withFocusedEditTopic topic fn editTopic =
    editTopic
        |> Maybe.andThen
            (\t ->
                if t.id == topic.id && t.focused then
                    Just (fn t)

                else
                    Nothing
            )


toolbarView :
    Model.State
    -> Topic
    -> Element Msg.Msg
toolbarView ({ app } as state) topic =
    let
        fontSize =
            Theme.secondaryFontSize app.theme

        fontColor =
            Widget.Color.toRgbColor Widget.Color.Grey400

        iconBtn icon text onPress =
            state
                |> toolbarIconBtn
                    { size = fontSize
                    , color = fontColor
                    , icon = icon
                    , text = text
                    , onPress = onPress
                    }

        toMsg =
            Msg.EditTopicMsg topic.id
    in
    row
        [ width shrink
        , height fill
        , alignRight
        , spacing BaseStyle.spacing
        , Font.size fontSize
        , Font.color fontColor
        ]
        [ iconBtn Icon.FormOutlined
            "编辑"
            (Just (toMsg EditTopic.InputFocusIn))
        ]


contentView :
    Model.State
    -> Topic
    -> Element Msg.Msg
contentView { app, withWidgetContext } topic =
    el
        ([ width fill
         , height fill
         ]
            ++ contentFont app.theme
        )
        (paragraph
            [ height shrink
            , centerY

            -- Note: 默认会设置为5，需显式归零
            , spacing 0
            ]
            [ withWidgetContext <|
                Markdown.render
                    { lineHeight = bgGridLineSpacing
                    }
                    topic.content
            ]
        )


toolbarIconBtn :
    { size : Int
    , icon : Icon
    , color : Color
    , text : String
    , onPress : Maybe msg
    }
    -> Model.State
    -> Element msg
toolbarIconBtn config { app } =
    let
        i18nText =
            I18n.text app.lang
    in
    Input.button
        [ mouseOver
            [ Font.color (Theme.primaryFontColor app.theme)
            ]
        ]
        { onPress = config.onPress
        , label =
            row
                [ spacing 2
                ]
                [ Icon.icon
                    { size = config.size
                    , color = config.color
                    }
                    config.icon
                , (I18n.btnModule :: config.text :: langEnd)
                    |> i18nText
                ]
        }


editTopicInput :
    Topic
    -> EditTopic
    -> Model.State
    -> Element Msg.Msg
editTopicInput topic editTopic { app, withWidgetContext } =
    let
        i18nText =
            I18n.text app.lang

        toMsg =
            Msg.EditTopicMsg topic.id
    in
    column
        [ width fill
        , height shrink
        , padding BaseStyle.spacing
        , spacing BaseStyle.spacing
        , Border.rounded 4
        , Background.color (rgb255 255 255 255)
        ]
        [ row
            [ width fill
            , spacing BaseStyle.spacing
            ]
            ([ "表情", "图片", "附件", "语音", "视频" ]
                |> List.map
                    (\t ->
                        Input.button
                            [ width (px 32)
                            , alignLeft
                            , Font.center
                            ]
                            { onPress = Nothing
                            , label = text t
                            }
                    )
            )
        , column
            (PrimaryBorder.all 1 app.theme
                ++ [ width fill
                   , height fill
                   , Border.rounded 3
                   ]
            )
            [ Input.multiline
                [ width fill
                , Border.width 0
                , Event.on "blur"
                    (Input.selectionDecoder
                        |> Decode.map
                            (\selection ->
                                toMsg
                                    (EditTopic.InputFocusBlur
                                        selection
                                    )
                            )
                    )
                ]
                { onChange =
                    \text ->
                        toMsg
                            (EditTopic.InputContentChanged text)
                , text = editTopic.content
                , selection = editTopic.selection
                , placeholder = Nothing
                , label = Input.labelHidden ""
                , spellcheck = False
                }
            , column
                [ width fill
                , paddingXY BaseStyle.spacing 0
                ]
                [ el
                    (PrimaryBorder.top 1 app.theme
                        ++ [ width fill
                           ]
                    )
                    none
                ]
            , row
                [ width fill
                , spacing BaseStyle.spacing
                , padding BaseStyle.spacing
                ]
                [ paragraph
                    []
                    (List.singleton
                        ((I18n.labelModule :: "分类：" :: langEnd)
                            |> i18nText
                        )
                        ++ ([ "产品开发", "点滴(DianDi)", "功能设计" ]
                                |> List.map
                                    (\t ->
                                        text (t ++ " > ")
                                    )
                           )
                    )
                , paragraph
                    []
                    (List.singleton
                        ((I18n.labelModule :: "标签：" :: langEnd)
                            |> i18nText
                        )
                        ++ ([ "待办", "知识", "疑问", "+" ]
                                |> List.map
                                    (\t ->
                                        text (t ++ " ")
                                    )
                           )
                    )
                , withWidgetContext <|
                    Button.button
                        { id = "btn-edit-topic-ok-in-home"
                        , attrs =
                            Theme.primaryBtn app.theme
                                ++ [ alignRight
                                   ]
                        , content =
                            (I18n.btnModule :: "确定" :: langEnd)
                                |> i18nText
                        , onPress =
                            Just
                                (Msg.EditTopicUpdated topic.id)
                        }
                , withWidgetContext <|
                    Button.button
                        { id = "btn-edit-topic-cancel-in-home"
                        , attrs =
                            Theme.secondaryBtn app.theme
                                ++ [ alignRight
                                   ]
                        , content =
                            (I18n.btnModule :: "取消" :: langEnd)
                                |> i18nText
                        , onPress =
                            Just
                                (toMsg EditTopic.InputFocusOut)
                        }
                ]
            ]
        ]


contentFont : Theme -> List (Attribute msg)
contentFont theme =
    [ Font.size (Theme.primaryFontSize theme)
    ]


holeBgColor : Theme -> Color
holeBgColor =
    Theme.primaryGreyBackgroundColor


{-| 打孔区域分隔线颜色
-}
holeSeparatorColor : Color
holeSeparatorColor =
    Widget.Color.toRgbColor
        Widget.Color.Orange900


{-| 打孔区域分隔线尺寸
-}
holeSeparatorSize : Int
holeSeparatorSize =
    3


bgGridLineRgbColor : String
bgGridLineRgbColor =
    Widget.Html.toRgba (rgb255 145 209 211)


bgGridLineSpacing : Int
bgGridLineSpacing =
    32


bgGridLineSize : Int
bgGridLineSize =
    1


holeSvgImg : Theme -> String
holeSvgImg theme =
    -- https://stackoverflow.com/questions/62539360/svg-how-to-drop-an-inset-shadow-on-a-path-that-has-an-rgba-fill#answer-62627106
    -- Note: 保持尺寸和阴影设定，但背景可按需增减图片尺寸
    """
<svg xmlns="http://www.w3.org/2000/svg"
xmlns:xlink="http://www.w3.org/1999/xlink" width="96px" height="96px" viewBox="0 0 96 96">
<defs>
    <filter id="inset-shadow">
        <feColorMatrix in="SourceGraphic" type="matrix" values="0 0 0 0 0
    0 0 0 0 0
    0 0 0 0 0
    0 0 0 100 0" result="opaque-source"/>
        <feGaussianBlur stdDeviation="2"/>
        <!-- 阴影偏移 -->
        <feOffset dy="4"/>
        <feComposite operator="xor" in2="opaque-source"/>
        <feComposite operator="in" in2="opaque-source"/>
        <feComposite operator="over" in2="SourceGraphic"/>
    </filter>
</defs>
<circle filter="url(#inset-shadow)" cx="48" cy="50" r="32" fill="
"""
        ++ Widget.Html.toRgba (holeBgColor theme)
        ++ """
" />
</svg>
"""
        |> Base64.encode
        |> (++) "data:image/svg+xml;base64,"
