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


module View.Page.Layer.TopicEditor exposing (create)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (onEnter, onLoseFocus)
import Element.Font as Font
import Element.Input as Input
import I18n.Element exposing (textWith)
import I18n.I18n exposing (langTextEnd)
import Model
import Model.Error as Error
import Model.Operation.EditTopic exposing (EditTopic)
import Msg
import View.I18n.Home as I18n
import View.Style.Base as BaseStyle
import Widget.Color as Color
import Widget.Icon as Icon
import Widget.Loading as Loading
import Widget.Util.Basic exposing (fromMaybe)
import Widget.Widget.Button as Button
import Widget.Widget.Markdown as Markdown


type alias Config msg =
    { isNew : Bool
    , topic : Maybe EditTopic
    , onTitleChange : String -> msg
    , onContentPreviewedChange : Bool -> msg
    , onContentChange : String -> msg
    , onTagDeleted : String -> msg
    , onTagDone : msg
    , onTagChange : String -> msg
    , onEditDone : msg
    , onEditCanceled : msg
    }


create : Config Msg.Msg -> Model.State -> Element Msg.Msg
create config { app, theme, widgets, withI18nElement } =
    let
        i18nText =
            withI18nElement I18n.text

        title =
            config.topic |> fromMaybe "" .title

        content =
            config.topic |> fromMaybe "" .content

        tags =
            config.topic |> fromMaybe [] .tags

        taging =
            config.topic |> fromMaybe "" .taging

        previewed =
            config.topic |> fromMaybe False .previewed

        updating =
            config.topic |> fromMaybe False .updating

        error =
            config.topic |> fromMaybe Error.none .error
    in
    column
        (theme.primaryWhiteBackground
            ++ [ width (percent 70)
               , height fill
               , class "topic-edit-win"
               , padding BaseStyle.spacing2x
               , spacing BaseStyle.spacing2x
               , centerX
               , Border.rounded 4
               , styles
                    [ ( "margin"
                      , String.fromInt BaseStyle.spacing2x
                            ++ "px 0"
                      )
                    ]
               ]
            ++ (if updating then
                    [ inFront
                        (el
                            [ width fill
                            , height fill
                            , Background.color theme.layerBackgroundColor
                            ]
                            (row
                                [ centerX
                                , centerY
                                , Font.size 18
                                , Font.color theme.primaryWhiteBackgroundColor
                                ]
                                [ Loading.ball { width = 72, height = 72 }
                                , paragraph []
                                    [ ("数据正在保存中，请稍等片刻 ..." :: langTextEnd)
                                        |> i18nText
                                    ]
                                ]
                            )
                        )
                    ]

                else
                    []
               )
        )
        [ Input.text
            (theme.defaultInput
                ++ [ width fill
                   , height (px 42)
                   ]
            )
            { onChange = config.onTitleChange
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
                (([ "表情", "图片", "附件", "视频" ]
                    |> List.map
                        (\t ->
                            widgets.with <|
                                Button.link
                                    { attrs =
                                        [ paddingXY 4 0
                                        ]
                                    , content =
                                        (I18n.buttonText :: t :: langTextEnd)
                                            |> i18nText
                                    , onPress = Nothing
                                    }
                        )
                 )
                    ++ [ Input.checkbox
                            [ width shrink
                            , alignRight
                            ]
                            { onChange = config.onContentPreviewedChange
                            , icon = Input.defaultCheckbox
                            , checked = previewed
                            , label =
                                Input.labelRight
                                    [ Font.size 14
                                    , Font.letterSpacing 0.39998
                                    , Font.weight 500
                                    ]
                                    ((I18n.buttonText :: "预览" :: langTextEnd)
                                        |> i18nText
                                    )
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
                        [ id app.topicEditInputId
                        , width fill
                        , height fill
                        , class "content"
                        , spacing (20 - theme.primaryFontSize)
                        , Border.width 0
                        ]
                        { onChange = config.onContentChange
                        , text = content
                        , selection = Just { start = 0, end = 0, direction = "" }
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

                 else if content |> String.isEmpty then
                    el
                        (theme.placeholderFont
                            ++ [ width fill
                               , height fill
                               , padding 12
                               ]
                        )
                        (("没有可预览内容，请先写点什么吧 :)" :: langTextEnd)
                            |> i18nText
                        )

                 else
                    paragraph
                        [ width fill
                        , height fill
                        , paddingXY 12 9
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
                                            , onPress = Just (config.onTagDeleted tag)
                                            }
                                    ]
                            )
                    )
                , el
                    [ width fill
                    ]
                    (Input.text
                        (theme.defaultInput
                            ++ [ id app.topicTagEditInputId
                               , height (px 42)
                               , onEnter config.onTagDone
                               , onLoseFocus config.onTagDone
                               ]
                        )
                        { onChange = config.onTagChange
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
        , (if
            app.device.class
                == Phone
                && app.device.orientation
                == Portrait
           then
            column

           else
            row
          )
            [ width fill
            , spacing BaseStyle.spacing2x
            ]
            [ case error of
                Error.Error e ->
                    paragraph
                        [ Font.color (Color.toRgbColor Color.Red900)
                        ]
                        [ text "* "
                        , textWith e
                        ]

                Error.Info e ->
                    paragraph
                        [ Font.color (Color.toRgbColor Color.Green900)
                        ]
                        [ text "* "
                        , textWith e
                        ]

                _ ->
                    none
            , row
                [ alignRight
                , spacing BaseStyle.spacing
                ]
                [ widgets.with <|
                    Button.button
                        { attrs = theme.primaryBtn ++ []
                        , content =
                            (I18n.buttonText
                                :: (if config.isNew then
                                        "记下来！"

                                    else
                                        "保存"
                                   )
                                :: langTextEnd
                            )
                                |> i18nText
                        , onPress = Just config.onEditDone
                        }
                , widgets.with <|
                    Button.button
                        { attrs = theme.secondaryBtn ++ []
                        , content =
                            (I18n.buttonText :: "取消" :: langTextEnd)
                                |> i18nText
                        , onPress =
                            Just config.onEditCanceled
                        }
                ]
            ]
        ]
