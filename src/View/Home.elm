module View.Home exposing (view)

import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import I18n.Lang exposing (langEnd)
import Model.Root exposing (RemoteData(..), RootModel)
import Model.User
import Msg exposing (RootMsg)
import Style.Default
import Style.Home
import Theme.Icon
import Theme.Icon.Element
import View.I18n.Home exposing (i18nBtnModule, i18nLabelModule)
import View.Topic.Category.List
import View.Topic.List
import Widget.Button


view : RootModel -> Element RootMsg
view ({ theme, lang } as model) =
    let
        i18nText =
            -- View.I18n.Home.i18nText I18n.Lang.En_US
            View.I18n.Home.i18nText lang
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
                    { src = "/logo.svg", description = "" }

                -- TODO 点击后，弹出搜索窗口，并在输入时实时查询结果，同时，展示常用搜索和收藏的搜索
                , iconBtn
                    [ alignRight
                    ]
                    Msg.NoOp
                    Theme.Icon.SearchOutlined
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
                    Theme.Icon.ArrowLeftOutlined
                , iconBtn
                    [ alignRight
                    ]
                    Msg.NoOp
                    Theme.Icon.PlusOutlined
                ]
            , el
                [ width fill
                , height fill
                , scrollbarY
                ]
                (View.Topic.Category.List.view model)
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
                [ Widget.Button.secondary
                    []
                    { theme = theme
                    , content =
                        row
                            [ spacing 8
                            ]
                            [ Theme.Icon.Element.icon
                                { size = 16
                                , color = rgb255 255 255 255
                                }
                                Theme.Icon.SettingOutlined
                            , -- TODO 点击后，在左侧弹出侧边栏，该侧边栏中展示用户头像/名称、语言切换、主题切换等
                              (i18nBtnModule :: "设置" :: langEnd)
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
                            { src = "/icon.svg", description = "" }
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
                                    Theme.Icon.FilterOutlined
                               ]
                        )
                    ]
                , el
                    [ width fill
                    , height fill
                    , scrollbarY
                    ]
                    (View.Topic.List.view model)

                -- TODO 输入框，待提取，以支持以弹窗方式添加子主题
                , column
                    (Style.Default.boundaryBorderEach
                        { top = 1
                        , right = 0
                        , bottom = 0
                        , left = 0
                        }
                        ++ [ width fill
                           , height (px (244 - 70))
                           , padding 8
                           , spacing 8
                           ]
                    )
                    [ row
                        [ width fill
                        , spacing 8
                        ]
                        (([ "表情", "图片", "附件", "语音", "视频" ]
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
                            ++ [ Input.button
                                    [ alignRight
                                    ]
                                    { onPress = Nothing
                                    , label =
                                        -- TODO 改为切换开关，开启后，在上部或下部以浮窗形式展开，固定高度并显示滚动条
                                        (i18nBtnModule :: "实时预览" :: langEnd)
                                            |> i18nText
                                    }
                               ]
                        )
                    , column
                        (Style.Default.boundaryBorderAll 1
                            ++ [ width fill
                               , height fill
                               , Border.rounded 3
                               ]
                        )
                        [ Input.multiline
                            [ width fill
                            , height
                                -- TODO 未得到焦点时，保持最小高度，在得到焦点后，自动扩展高度至最大
                                (fill
                                    |> maximum (150 - 70)
                                )
                            , Border.width 0
                            , focused []
                            ]
                            { onChange = \_ -> Msg.NoOp
                            , text = ""
                            , placeholder =
                                Just
                                    (Input.placeholder
                                        []
                                        (("又有什么奇妙的想法呢？赶紧记下来吧 :)" :: langEnd)
                                            |> i18nText
                                        )
                                    )
                            , label = Input.labelHidden ""
                            , spellcheck = False
                            }
                        , column
                            [ width fill
                            , paddingXY 8 0
                            ]
                            [ el
                                (Style.Default.boundaryBorderEach
                                    { top = 1
                                    , right = 0
                                    , bottom = 0
                                    , left = 0
                                    }
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
                                    ((i18nLabelModule :: "分类：" :: langEnd)
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
                                    ((i18nLabelModule :: "标签：" :: langEnd)
                                        |> i18nText
                                    )
                                    ++ ([ "待办", "知识", "疑问", "+" ]
                                            |> List.map
                                                (\t ->
                                                    text (t ++ " ")
                                                )
                                       )
                                )
                            , Widget.Button.primary
                                [ alignRight
                                ]
                                { theme = theme
                                , content =
                                    (i18nBtnModule :: "记下来!" :: langEnd)
                                        |> i18nText
                                , onPress = Nothing
                                }
                            ]
                        ]
                    ]
                ]
            , column
                (Style.Default.boundaryBorderEach
                    { top = 0
                    , right = 0
                    , bottom = 0
                    , left = 1
                    }
                    ++ [ width (px (128 * 3))
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


userName : Model.User.User -> String
userName user =
    case user of
        Model.User.None ->
            "匿名"

        Model.User.User u ->
            u.name


icon : Theme.Icon.Icon -> Element msg
icon =
    Theme.Icon.Element.icon
        { size = 16
        , color = rgb255 6 126 213
        }


iconBtn :
    List (Attribute msg)
    -> msg
    -> Theme.Icon.Icon
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
