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
import Data.TreeStore as TreeStore
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import I18n.Lang exposing (langEnd)
import Model
import Model.App as App
import Model.Operation.EditTopic as EditTopic exposing (EditTopic)
import Model.Topic exposing (Topic)
import Msg
import Theme.Theme exposing (Theme)
import View.I18n.Home as I18n
import View.Style.Base as BaseStyle
import View.Style.Border.Primary as PrimaryBorder
import Widget.Color
import Widget.Dimension as Dimension
import Widget.Html exposing (onInputBlur, styles)
import Widget.Icon as Icon exposing (Icon)
import Widget.Widget.Button as Button
import Widget.Widget.Markdown as Markdown


view :
    Model.State
    -> Topic
    -> Element Msg.Msg
view ({ app, theme } as state) topic =
    let
        cornerRoundedSize =
            4

        -- 孔洞宽度
        holeWidth =
            textLineHeight

        -- 孔洞左侧留白大小
        holePaddingLeft =
            4

        -- 打孔区域宽度
        holePaneWidth =
            holeWidth
                + holePaddingLeft
                -- 格线左移位置
                + 8

        -- 孔洞分隔线尺寸
        holeSeparatorSize =
            3

        toolbarHeight =
            20
    in
    column
        [ id topic.id
        , width fill
        , Background.color (rgb255 255 255 255)
        , Border.rounded cornerRoundedSize
        , paddingEach
            (Dimension.left holePaneWidth)

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
        , behindContent
            -- 打孔卡片背景
            (row
                [ width fill
                , height fill
                , paddingEach
                    { top = toolbarHeight
                    , left = holePaddingLeft
                    , right = 0

                    -- Note: 减少一点底部空白以显示最后一条格线
                    , bottom = toolbarHeight - 2
                    }
                , inFront
                    -- 孔洞隔断线
                    (el
                        [ height fill
                        , moveRight (toFloat (holePaneWidth - holeSeparatorSize))
                        , Border.widthEach
                            (Dimension.right holeSeparatorSize)
                        , Border.solid
                        , Border.color holeSeparatorColor
                        ]
                        none
                    )
                ]
                [ el
                    -- 孔洞
                    [ width (px holeWidth)
                    , height fill
                    , styles
                        [ ( "background-image"
                          , "url(\"" ++ holeSvgImg theme ++ "\")"
                          )
                        , ( "background-repeat", "repeat-y" )
                        , ( "background-size"
                          , String.fromInt holeWidth ++ "px"
                          )
                        ]
                    ]
                    none
                , el
                    -- 格线
                    [ width fill
                    , height fill
                    , styles
                        [ ( "background-image"
                          , "linear-gradient("
                                ++ bgGridLineRgbColor
                                ++ " "
                                ++ String.fromInt textGridLineSize
                                ++ "px, transparent 0)"
                          )
                        , ( "background-size"
                          , "100% "
                                ++ String.fromInt textLineHeight
                                ++ "px"
                          )
                        ]
                    ]
                    none
                ]
            )
        ]
        [ app.editTopic
            |> withFocusedEditTopic topic
                (\editTopic ->
                    el
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
            |> Maybe.withDefault
                (column
                    [ width fill
                    , paddingEach
                        (Dimension.horizontal BaseStyle.spacing2x)
                    ]
                    [ el
                        [ width fill
                        , height (px toolbarHeight)
                        ]
                        (toolbarView state topic)
                    , topicView state topic
                    , el
                        [ width fill
                        , height (px toolbarHeight)
                        ]
                        none
                    ]
                )
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
toolbarView ({ app, theme } as state) topic =
    let
        fontSize =
            theme.secondaryFontSize

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
        [ width fill
        , height fill
        , Font.size fontSize
        , Font.color fontColor
        ]
        [ row
            [ width shrink
            , height fill
            , alignLeft
            , spacing BaseStyle.spacing
            ]
            [ topicCategoryView state topic
            ]
        , row
            [ width shrink
            , height fill
            , alignRight
            , spacing BaseStyle.spacing
            ]
            [ iconBtn Icon.FormOutlined
                "编辑"
                (Just (toMsg EditTopic.InputFocusIn))
            ]
        ]


topicView :
    Model.State
    -> Topic
    -> Element Msg.Msg
topicView { app, theme, withWidgetContext } topic =
    el
        ([ width fill
         , height fill
         ]
            ++ contentFont theme
        )
        (paragraph
            [ height shrink
            , centerY

            -- Note: 默认会设置为5，需显式归零
            , spacing 0
            ]
            [ withWidgetContext <|
                Markdown.render
                    { lineHeight = textLineHeight
                    }
                    topic.content
            ]
        )


topicCategoryView :
    Model.State
    -> Topic
    -> Element Msg.Msg
topicCategoryView { app, theme } topic =
    let
        getCategoriesBy categoryId =
            app
                |> App.mapCategories
                    (\cats ->
                        Just
                            (TreeStore.getAllByParentPath
                                categoryId
                                cats
                            )
                    )

        categories =
            topic.category
                |> Maybe.andThen getCategoriesBy
                |> Maybe.withDefault []
    in
    row
        [ spacing 4
        ]
        (categories
            |> List.map (.name >> text)
            |> List.intersperse (text "•")
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
toolbarIconBtn config { app, theme } =
    let
        i18nText =
            I18n.text app.lang
    in
    Input.button
        [ mouseOver
            [ Font.color theme.primaryFontColor
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
editTopicInput topic editTopic { app, theme, withWidgetContext } =
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
            (PrimaryBorder.all 1 theme
                ++ [ width fill
                   , height fill
                   , Border.rounded 3
                   ]
            )
            [ Input.multiline
                [ width fill
                , Border.width 0
                , onInputBlur (\s -> toMsg (EditTopic.InputFocusBlur s))
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
                    (PrimaryBorder.top 1 theme
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
                            theme.primaryBtn
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
                            theme.secondaryBtn
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


contentFont : Theme msg -> List (Attribute msg)
contentFont theme =
    [ Font.size theme.primaryFontSize
    ]


holeBgColor : Theme msg -> Color
holeBgColor =
    .primaryGreyBackgroundColor


{-| 打孔区域分隔线颜色
-}
holeSeparatorColor : Color
holeSeparatorColor =
    Widget.Color.toRgbColor
        Widget.Color.Orange900


bgGridLineRgbColor : String
bgGridLineRgbColor =
    Widget.Html.toRgba (rgb255 145 209 211)


textLineHeight : Int
textLineHeight =
    32


textGridLineSize : Int
textGridLineSize =
    1


holeSvgImg : Theme msg -> String
holeSvgImg theme =
    -- https://stackoverflow.com/questions/62539360/svg-how-to-drop-an-inset-shadow-on-a-path-that-has-an-rgba-fill#answer-62627106
    -- Note: 保持尺寸和阴影设定，确保圆形与画布边缘有合适的空白
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
