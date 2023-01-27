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


module View.Page.Home exposing (view)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Event
import Element.Font as Font
import Element.Input as Input
import I18n.Lang exposing (langEnd)
import Json.Decode as Decode
import Model
import Msg
import Theme.Theme as Theme
import View.I18n.Home as I18n
import View.Page.Topic.Category.List
import View.Page.Topic.List
import View.Style.Border.Primary
import Widget.Icon exposing (Icon)
import Widget.Part.Button


view : Model.State -> Element Msg.Msg
view ({ app, widgets } as state) =
    let
        i18nText =
            I18n.text app.lang
    in
    row
        [ width fill
        , height fill

        -- for child scrollbar: https://github.com/mdgriffith/elm-ui/issues/149#issuecomment-582229271
        , clip
        ]
        [ column
            [ width (px 256)
            , height fill
            ]
            [ row
                (View.Style.Border.Primary.bottom 1 app.theme
                    ++ [ width fill
                       , height (px 70)
                       , Background.color (rgb255 255 255 255)
                       , paddingXY 16 8
                       ]
                )
                [ image
                    [ width shrink
                    , height (px (70 - 8 * 2))
                    , centerX
                    , pointer
                    ]
                    { src = "/logo.svg", description = "", onLoad = Nothing }
                ]
            , el
                [ width fill
                , height fill
                , scrollbarY
                ]
                (View.Page.Topic.Category.List.view state)
            , row
                (View.Style.Border.Primary.top 1 app.theme
                    ++ [ width fill
                       , height shrink
                       , padding 8
                       ]
                )
                [ Widget.Part.Button.button widgets
                    { id = "btn-personal-setting-in-home"
                    , attrs = Theme.secondaryBtn app.theme
                    , content =
                        row
                            [ spacing 8
                            ]
                            [ Widget.Icon.icon
                                { size = 16
                                , color = rgb255 255 255 255
                                }
                                Widget.Icon.SettingOutlined
                            , -- TODO 点击后，在左侧弹出侧边栏，该侧边栏中展示用户头像/名称、语言切换、主题切换等
                              (I18n.btnModule :: "设置" :: langEnd)
                                |> i18nText
                            ]
                    , onPress = Nothing
                    }

                -- TODO 点击后，弹出搜索窗口，并在输入时实时查询结果，同时，展示常用搜索和收藏的搜索
                , iconBtn
                    [ alignRight
                    ]
                    Msg.NoOp
                    Widget.Icon.SearchOutlined
                ]
            ]
        , row
            [ width fill
            , height fill
            ]
            [ column
                [ width fill
                , height fill
                , paddingEach { top = 56, left = 0, right = 0, bottom = 0 }

                -- box-shadow: 0px 2px 4px -1px rgba(0,0,0,0.2),0px 4px 5px 0px rgba(0,0,0,0.14),0px 1px 10px 0px rgba(0,0,0,0.12);
                , Border.shadows
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
                , inFront
                    (row
                        [ width fill
                        , height (px 56)
                        , Background.color (rgb255 255 255 255)
                        , paddingXY 16 8

                        -- box-shadow: 0px 3px 1px -2px rgba(0,0,0,0.2),0px 3px 1px 0px rgba(0,0,0,0.14),0px 1px 1px 0px rgba(0,0,0,0.12);
                        , Border.shadows
                            [ { inset = False
                              , offset = ( 0, 3 )
                              , blur = 1
                              , size = -2
                              , color = rgba255 0 0 0 0.2
                              }
                            , { inset = False
                              , offset = ( 0, 3 )
                              , blur = 1
                              , size = 0
                              , color = rgba255 0 0 0 0.14
                              }
                            , { inset = False
                              , offset = ( 0, 1 )
                              , blur = 1
                              , size = 0
                              , color = rgba255 0 0 0 0.12
                              }
                            ]
                        ]
                        [ row
                            [ width fill
                            , height shrink
                            , spacing 8
                            , centerY
                            ]
                            (state
                                |> Model.getSelectedTopicCategory
                                |> Maybe.map
                                    (\category ->
                                        [ category.icon
                                            |> Maybe.map
                                                (\src ->
                                                    image
                                                        [ width (px (56 - 8 * 2))
                                                        ]
                                                        { src = src
                                                        , description = ""
                                                        , onLoad = Nothing
                                                        }
                                                )
                                            |> Maybe.withDefault
                                                (Widget.Icon.icon
                                                    { size = 56 - 8 * 2
                                                    , color = Theme.primaryFontColor app.theme
                                                    }
                                                    Widget.Icon.QuestionCircleOutlined
                                                )
                                        , column
                                            [ spacing 8
                                            ]
                                            [ el
                                                [ Font.size 18
                                                ]
                                                (text category.name)
                                            , category.description
                                                |> Maybe.map
                                                    (\desc ->
                                                        el
                                                            [ Font.size (18 - 8)
                                                            ]
                                                            (text desc)
                                                    )
                                                |> Maybe.withDefault
                                                    (el
                                                        (Theme.placeholderFont app.theme
                                                            ++ [ Font.size (18 - 8)
                                                               ]
                                                        )
                                                        (("点击这里添加描述信息" :: langEnd)
                                                            |> i18nText
                                                        )
                                                    )
                                            ]
                                        ]
                                    )
                                |> Maybe.withDefault []
                            )
                        , row
                            [ width fill
                            , paddingXY 8 0
                            , spacing 8
                            ]
                            (([ [ "待办", "20" ], [ "知识", "10" ], [ "疑问", "5" ] ]
                                |> List.map
                                    (\t ->
                                        Input.button
                                            [ alignRight
                                            ]
                                            { onPress = Nothing
                                            , label = t |> i18nText
                                            }
                                    )
                             )
                                ++ [ el
                                        (View.Style.Border.Primary.right 1 app.theme
                                            ++ [ height fill
                                               , alignRight
                                               ]
                                        )
                                        none
                                   , iconBtn
                                        [ alignRight
                                        ]
                                        Msg.NoOp
                                        Widget.Icon.FilterOutlined
                                   ]
                            )
                        ]
                    )
                ]
                [ el
                    [ width fill
                    , height fill
                    , clip

                    -- , inFront
                    --     (el
                    --         [ centerY
                    --         , alignRight
                    --         -- 主题列表右侧间距 - 按钮宽度 - 浮动工具栏左侧间距
                    --         , moveLeft (64 - 48 - 8)
                    --         ]
                    --         (Widget.Part.Button.button widgets
                    --             { id = "btn-add-topic-in-home"
                    --             , attrs =
                    --                 Theme.primaryBtn app.theme
                    --                     ++ [ width (px 48)
                    --                        , height (px 48)
                    --                        , padding 8
                    --                        , Border.rounded 24
                    --                        ]
                    --             , content =
                    --                 el []
                    --                     (Widget.Icon.icon
                    --                         { size = 32
                    --                         , color = rgb255 255 255 255
                    --                         }
                    --                         Widget.Icon.PlusOutlined
                    --                     )
                    --             , onPress = Nothing
                    --             }
                    --         )
                    --     )
                    ]
                    (el
                        (Theme.primaryGreyBackground app.theme
                            ++ [ width fill
                               , height fill
                               , scrollbarY
                               , paddingXY 64 16
                               ]
                        )
                        (View.Page.Topic.List.view state)
                    )
                , topicNewInput state
                ]
            , column
                [ width (px (128 * 4))
                , height fill
                , padding 8
                ]
                [ paragraph
                    [ centerX
                    , centerY
                    ]
                    [ ("这里是主题详情展示页，默认显示当前分类的信息" :: langEnd)
                        |> i18nText
                    ]
                ]
            ]
        ]


icon : Icon -> Element msg
icon =
    Widget.Icon.icon
        { size = 16
        , color = rgb255 6 126 213
        }


iconBtn :
    List (Attribute msg)
    -> msg
    -> Icon
    -> Element msg
iconBtn attr onPress i =
    Input.button
        (attr
            ++ [ width (px 16)
               , focused []
               ]
        )
        { onPress = Just onPress
        , label = icon i
        }


topicNewInput : Model.State -> Element Msg.Msg
topicNewInput ({ app } as state) =
    let
        inputId =
            "topic-new-input"
    in
    column
        (View.Style.Border.Primary.top 1 app.theme
            ++ [ width fill
               , padding 8
               , spacing 8
               ]
        )
        (topicNewInputWhenGotFocus
            app.topicNewInputFocused
            inputId
            state
        )


topicNewInputWhenGotFocus :
    Bool
    -> String
    -> Model.State
    -> List (Element Msg.Msg)
topicNewInputWhenGotFocus needToBeExpanded inputId { app, widgets } =
    let
        i18nText =
            I18n.text app.lang
    in
    (if needToBeExpanded then
        [ row
            [ width fill
            , spacing 8
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
        ]

     else
        []
    )
        ++ [ column
                (View.Style.Border.Primary.all 1 app.theme
                    ++ [ width fill
                       , height fill
                       , Border.rounded 3
                       ]
                )
                (Input.multiline
                    [ id inputId
                    , width fill
                    , height
                        (if needToBeExpanded then
                            px (40 * 4)

                         else
                            px 40
                        )
                    , Border.width 0
                    , Event.on "blur"
                        (Input.selectionDecoder
                            |> Decode.map Msg.NewTopicInputFocusLost
                        )
                    , Event.onFocus
                        (Msg.NewTopicInputFocusGot inputId True)
                    ]
                    { onChange = Msg.NewTopicInputContentChanged
                    , text = app.topicNewInputContent
                    , selection = app.topicNewInputSelection
                    , placeholder =
                        Just
                            (Input.placeholder
                                (Theme.placeholderFont app.theme)
                                (("又有什么奇妙的想法呢？赶紧记下来吧 :)" :: langEnd)
                                    |> i18nText
                                )
                            )
                    , label = Input.labelHidden ""
                    , spellcheck = False
                    }
                    :: (if needToBeExpanded then
                            [ column
                                [ width fill
                                , paddingXY 8 0
                                ]
                                [ el
                                    (View.Style.Border.Primary.top 1 app.theme
                                        ++ [ width fill
                                           ]
                                    )
                                    none
                                ]
                            , row
                                [ width fill
                                , spacing 8
                                , padding 8
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
                                , Widget.Part.Button.button widgets
                                    { id = "btn-write-it-down-in-home"
                                    , attrs =
                                        Theme.primaryBtn app.theme
                                            ++ [ alignRight
                                               ]
                                    , content =
                                        (I18n.btnModule :: "记下来!" :: langEnd)
                                            |> i18nText
                                    , onPress = Just (Msg.NewTopicAdded inputId)
                                    }
                                ]
                            ]

                        else
                            []
                       )
                )
           ]
