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
import Element.Font as Font
import Element.Input as Input
import I18n.Lang exposing (langEnd)
import Model
import Msg
import Style.Default
import Style.Home
import Theme.Theme
import View.I18n.Home as I18n
import View.Page.Topic.Category.List
import View.Page.Topic.List
import Widget.Color
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
            (Style.Default.boundaryBorderEach
                { top = 0
                , right = 1
                , bottom = 0
                , left = 0
                }
                ++ [ width (px 256)
                   , height fill
                   ]
            )
            [ row
                Style.Home.topBar
                [ image
                    (Style.Home.logoInTopBar
                        ++ [ alignLeft, pointer ]
                    )
                    { src = "/logo.svg", description = "", onLoad = Nothing }

                -- TODO 点击后，弹出搜索窗口，并在输入时实时查询结果，同时，展示常用搜索和收藏的搜索
                , iconBtn
                    [ alignRight
                    ]
                    Msg.NoOp
                    Widget.Icon.SearchOutlined
                ]
            , row
                (Style.Default.boundaryBorderEach
                    { top = 0
                    , right = 0
                    , bottom = 1
                    , left = 0
                    }
                    ++ [ width fill
                       , padding 8
                       ]
                )
                [ iconBtn
                    []
                    Msg.NoOp
                    Widget.Icon.ArrowLeftOutlined
                , iconBtn
                    [ alignRight
                    ]
                    Msg.NoOp
                    Widget.Icon.PlusOutlined
                ]
            , el
                [ width fill
                , height fill
                , scrollbarY
                ]
                (View.Page.Topic.Category.List.view state)
            , row
                (Style.Default.boundaryBorderEach
                    { top = 1
                    , right = 0
                    , bottom = 0
                    , left = 0
                    }
                    ++ [ width fill
                       , height shrink
                       , padding 8
                       ]
                )
                [ Widget.Part.Button.button widgets
                    { id = "btn-personal-setting-in-home"
                    , attrs = Theme.Theme.secondaryBtn app.theme
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
                ]
            ]
        , row
            [ width fill
            , height fill
            ]
            [ column
                [ width fill
                , height fill
                ]
                [ row
                    (Style.Home.topBar
                        ++ [ width fill
                           ]
                    )
                    [ row
                        [ width fill
                        , height shrink
                        , spacing 8
                        , centerY
                        ]
                        [ image
                            [ width (px (64 - 8 * 2))
                            ]
                            { src = "/icon.svg", description = "", onLoad = Nothing }
                        , column
                            [ spacing 8
                            ]
                            [ el
                                [ Font.size 20
                                ]
                                (text "点滴")
                            , el
                                [ Font.size 10
                                ]
                                (("这里是类别描述信息" :: langEnd)
                                    |> i18nText
                                )
                            ]
                        ]
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
                                    (Style.Default.boundaryBorderEach
                                        { top = 0
                                        , right = 1
                                        , bottom = 0
                                        , left = 0
                                        }
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
                , el
                    [ width fill
                    , height fill
                    , clip
                    , inFront
                        (el
                            [ centerY
                            , alignRight
                            ]
                            (Widget.Part.Button.button widgets
                                { id = "btn-add-topic-in-home"
                                , attrs =
                                    Theme.Theme.primaryBtn app.theme
                                        ++ [ width (px 48)
                                           , height (px 48)
                                           , padding 8
                                           , Border.rounded 24
                                           , moveLeft (64 - 48 - 8)
                                           ]
                                , content =
                                    el []
                                        (Widget.Icon.icon
                                            { size = 32
                                            , color = rgb255 255 255 255
                                            }
                                            Widget.Icon.PlusOutlined
                                        )
                                , onPress = Nothing
                                }
                            )
                        )
                    ]
                    (el
                        [ width fill
                        , height fill
                        , scrollbarY
                        , paddingXY 64 16
                        , Background.color
                            (Widget.Color.Grey200
                                |> Widget.Color.toRgbColor
                            )
                        ]
                        (View.Page.Topic.List.view state)
                    )

                -- -- TODO 输入框，待提取，以支持以弹窗方式添加子主题
                -- , column
                --     (Style.Default.boundaryBorderEach
                --         { top = 1
                --         , right = 0
                --         , bottom = 0
                --         , left = 0
                --         }
                --         ++ [ width fill
                --            , height (px (244 - 70))
                --            , padding 8
                --            , spacing 8
                --            ]
                --     )
                --     [ row
                --         [ width fill
                --         , spacing 8
                --         ]
                --         (([ "表情", "图片", "附件", "语音", "视频" ]
                --             |> List.map
                --                 (\t ->
                --                     Input.button
                --                         [ width (px 32)
                --                         , alignLeft
                --                         , Font.center
                --                         ]
                --                         { onPress = Nothing
                --                         , label = text t
                --                         }
                --                 )
                --          )
                --             ++ [ Input.button
                --                     [ alignRight
                --                     ]
                --                     { onPress = Nothing
                --                     , label =
                --                         -- TODO 改为切换开关，开启后，在上部或下部以浮窗形式展开，固定高度并显示滚动条
                --                         (I18n.btnModule :: "实时预览" :: langEnd)
                --                             |> i18nText
                --                     }
                --                ]
                --         )
                --     , column
                --         (Style.Default.boundaryBorderAll 1
                --             ++ [ width fill
                --                , height fill
                --                , Border.rounded 3
                --                ]
                --         )
                --         [ Input.multiline
                --             [ width fill
                --             , height
                --                 -- TODO 未得到焦点时，保持最小高度，在得到焦点后，自动扩展高度至最大
                --                 (fill
                --                     |> maximum (150 - 70)
                --                 )
                --             , Border.width 0
                --             , focused []
                --             ]
                --             { onChange = \_ -> Msg.NoOp
                --             , text = ""
                --             , placeholder =
                --                 Just
                --                     (Input.placeholder
                --                         (Theme.Theme.placeholderFont app.theme)
                --                         (("又有什么奇妙的想法呢？赶紧记下来吧 :)" :: langEnd)
                --                             |> i18nText
                --                         )
                --                     )
                --             , label = Input.labelHidden ""
                --             , spellcheck = False
                --             }
                --         , column
                --             [ width fill
                --             , paddingXY 8 0
                --             ]
                --             [ el
                --                 (Style.Default.boundaryBorderEach
                --                     { top = 1
                --                     , right = 0
                --                     , bottom = 0
                --                     , left = 0
                --                     }
                --                     ++ [ width fill
                --                        ]
                --                 )
                --                 none
                --             ]
                --         , row
                --             [ width fill
                --             , spacing 8
                --             , padding 8
                --             ]
                --             [ paragraph
                --                 []
                --                 (List.singleton
                --                     ((I18n.labelModule :: "分类：" :: langEnd)
                --                         |> i18nText
                --                     )
                --                     ++ ([ "产品开发", "点滴(DianDi)", "功能设计" ]
                --                             |> List.map
                --                                 (\t ->
                --                                     text (t ++ " > ")
                --                                 )
                --                        )
                --                 )
                --             , paragraph
                --                 []
                --                 (List.singleton
                --                     ((I18n.labelModule :: "标签：" :: langEnd)
                --                         |> i18nText
                --                     )
                --                     ++ ([ "待办", "知识", "疑问", "+" ]
                --                             |> List.map
                --                                 (\t ->
                --                                     text (t ++ " ")
                --                                 )
                --                        )
                --                 )
                --             , Widget.Button.button widgets
                --                 { id = "btn-write-it-down-in-home"
                --                 , attrs =
                --                     Theme.Theme.primaryBtn app.theme
                --                         ++ [ alignRight
                --                            ]
                --                 , content =
                --                     (I18n.btnModule :: "记下来!" :: langEnd)
                --                         |> i18nText
                --                 , onPress = Nothing
                --                 }
                --             ]
                --         ]
                --     ]
                ]
            , column
                (Style.Default.boundaryBorderEach
                    { top = 0
                    , right = 0
                    , bottom = 0
                    , left = 1
                    }
                    ++ [ width (px (128 * 4))
                       , height fill
                       , padding 8
                       ]
                )
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
