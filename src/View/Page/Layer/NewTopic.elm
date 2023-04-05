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


module View.Page.Layer.NewTopic exposing (create)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onEnter)
import Element.Font as Font
import Element.Input as Input
import I18n.I18n exposing (langTextEnd)
import Model
import Model.Operation.NewTopic as NewTopic
import Msg
import View.I18n.Home as I18n
import View.Page as Page
import View.Style.Base as BaseStyle
import Widget.Color as Color
import Widget.Icon as Icon
import Widget.Util.Basic exposing (fromMaybe)
import Widget.Widget.Button as Button
import Widget.Widget.Markdown as Markdown


create : Model.State -> Element Msg.Msg
create { app, theme, widgets, withI18nElement } =
    let
        i18nText =
            withI18nElement I18n.text

        title =
            app.newTopic |> fromMaybe "" .title

        content =
            app.newTopic |> fromMaybe "" .content

        tags =
            app.newTopic |> fromMaybe [] .tags

        taging =
            app.newTopic |> fromMaybe "" .taging

        previewed =
            app.newTopic |> fromMaybe False .previewed

        error =
            app.newTopic |> fromMaybe "" .error
    in
    column
        (theme.primaryWhiteBackground
            ++ [ height fill
               , class "topic-new-win"
               , padding BaseStyle.spacing2x
               , spacing BaseStyle.spacing2x
               , centerX
               , Border.rounded 4
               , styles
                    [ ( "width", "70% !important" )
                    , ( "margin"
                      , String.fromInt BaseStyle.spacing2x
                            ++ "px 0"
                      )
                    ]
               ]
        )
        [ Input.text
            (theme.defaultInput
                ++ [ width fill
                   , height (px 42)
                   ]
            )
            { onChange =
                \text ->
                    Msg.NewTopicMsg (NewTopic.TitleChanged text)
            , text = title
            , selection = Nothing
            , placeholder =
                Just
                    (Input.placeholder
                        theme.placeholderFont
                        (("可以在这里添加一个醒目的标题哦 ..." :: langTextEnd)
                            |> i18nText
                        )
                    )
            , label = Input.labelHidden ""
            }
        , column
            [ width fill
            , height fill
            ]
            [ row
                [ width fill
                , spacing BaseStyle.spacing
                ]
                (([ "表情", "图片", "附件", "语音", "视频" ]
                    |> List.map
                        (\t ->
                            widgets.with <|
                                Button.link
                                    { attrs =
                                        [ paddingXY 4 0
                                        ]
                                    , content = text t
                                    , onPress = Nothing
                                    }
                        )
                 )
                    ++ [ Input.checkbox
                            [ width shrink
                            , alignRight
                            ]
                            { onChange =
                                \checked ->
                                    Msg.NewTopicMsg
                                        (NewTopic.ContentPreviewed
                                            checked
                                        )
                            , icon = Input.defaultCheckbox
                            , checked = previewed
                            , label =
                                Input.labelRight
                                    [ moveUp 1
                                    ]
                                    (text "预览")
                            }
                       ]
                )
            , el
                (theme.defaultInput
                    ++ [ width fill
                       , height fill
                       , scrollbarY
                       ]
                )
                (if not previewed then
                    Input.multiline
                        [ width fill
                        , height fill
                        , class "content"
                        , spacing (20 - theme.primaryFontSize)
                        , Border.width 0
                        ]
                        { onChange =
                            \text ->
                                Msg.NewTopicMsg (NewTopic.ContentChanged text)
                        , text = content
                        , selection = Nothing
                        , placeholder =
                            Just
                                (Input.placeholder
                                    theme.placeholderFont
                                    (("又有什么奇妙的想法呢？赶紧记下来吧 :)" :: langTextEnd)
                                        |> i18nText
                                    )
                                )
                        , label = Input.labelHidden ""
                        , spellcheck = False
                        }

                 else
                    paragraph
                        [ width fill
                        , height fill
                        , paddingXY 11 9
                        ]
                        [ widgets.with <|
                            Markdown.render
                                { lineHeight = 20
                                }
                                content
                        ]
                )
            ]
        , row
            [ width fill
            ]
            [ el
                [ alignTop
                , paddingXY 0 8
                ]
                ((I18n.labelText :: "标签：" :: langTextEnd)
                    |> i18nText
                )
            , column
                [ width fill
                , spacing BaseStyle.spacing
                ]
                [ wrappedRow
                    [ width fill
                    , spacing BaseStyle.spacing
                    ]
                    (tags
                        |> List.map
                            (\tag ->
                                row
                                    [ spacing BaseStyle.spacing
                                    , padding 8
                                    , Border.rounded 4
                                    , Background.color (rgba255 25 118 210 0.1)
                                    , mouseOver
                                        [ Background.color (rgba255 25 118 210 0.2)
                                        ]
                                    ]
                                    [ text ("#" ++ tag)
                                    , widgets.with <|
                                        Button.circle
                                            { attrs = theme.secondaryBtn ++ [ centerX, padding 2 ]
                                            , content =
                                                el [ centerX ]
                                                    (theme.primaryBtnIcon
                                                        { icon = Icon.CloseOutlined, size = Just 8 }
                                                    )
                                            , onPress = Just (Msg.NewTopicMsg (NewTopic.TagDeleted tag))
                                            }
                                    ]
                            )
                    )
                , el
                    [ width fill
                    ]
                    (Input.text
                        (theme.defaultInput
                            ++ [ height (px 42)
                               , onEnter (Msg.NewTopicMsg NewTopic.TagDone)
                               ]
                        )
                        { onChange =
                            \text ->
                                Msg.NewTopicMsg (NewTopic.TagChanged text)
                        , text = taging
                        , selection = Nothing
                        , placeholder =
                            Just
                                (Input.placeholder
                                    theme.placeholderFont
                                    (("请输入标签名称，并按回车确认" :: langTextEnd)
                                        |> i18nText
                                    )
                                )
                        , label = Input.labelHidden ""
                        }
                    )
                ]
            ]
        , row
            [ width fill
            , spacing BaseStyle.spacing2x
            ]
            [ el
                [ Font.color (Color.toRgbColor Color.Red900)
                ]
                (if String.isEmpty error then
                    none

                 else
                    text ("* " ++ error)
                )
            , row
                [ alignRight
                , spacing BaseStyle.spacing
                ]
                [ widgets.with <|
                    Button.button
                        { attrs = theme.primaryBtn ++ []
                        , content =
                            (I18n.buttonText :: "记下来！" :: langTextEnd)
                                |> i18nText
                        , onPress = Just Msg.NewTopicAddedMsg
                        }
                , widgets.with <|
                    Button.button
                        { attrs = theme.secondaryBtn ++ []
                        , content =
                            (I18n.buttonText :: "取消" :: langTextEnd)
                                |> i18nText
                        , onPress =
                            Just
                                (Msg.batch
                                    [ Msg.NewTopicCleanedMsg
                                    , Msg.ClosePageLayerMsg Page.NewTopicLayer
                                    ]
                                )
                        }
                ]
            ]
        ]
