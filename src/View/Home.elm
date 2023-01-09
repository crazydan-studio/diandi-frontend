module View.Home exposing (create)

import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Model.Icon
import Model.Root exposing (RootModel)
import Model.User
import Msg exposing (RootMsg)
import Style.Basic
import Style.Home
import Style.Icon as Icon
import View.Topic.ListView


create : RootModel -> Element RootMsg
create model =
    row
        [ width fill
        , height fill

        -- for child scrollbar: https://github.com/mdgriffith/elm-ui/issues/149#issuecomment-582229271
        , clip
        ]
        [ column
            (Style.Basic.boundaryBorderEach
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
                    (Style.Home.logoInTopBar ++ [ alignLeft ])
                    { src = "/logo.svg", description = "" }

                -- TODO 点击后向左展开输入框，失焦后还原
                , iconBtn
                    [ alignRight
                    ]
                    Msg.NoOp
                    Model.Icon.SearchOutlined
                ]
            , row
                (Style.Basic.boundaryBorderEach
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
                    Model.Icon.ArrowLeftOutlined
                , iconBtn
                    [ alignRight
                    ]
                    Msg.NoOp
                    Model.Icon.PlusOutlined
                ]
            , column
                [ width fill
                , height fill
                , paddingEach { top = 0, left = 0, right = 0, bottom = 16 }
                , scrollbarY
                ]
                ([ "点滴", "点滴", "点滴", "点滴", "点滴", "点滴", "点滴", "点滴" ]
                    |> List.map
                        (\e ->
                            row
                                (Style.Basic.boundaryBorderEach
                                    { top = 0
                                    , right = 0
                                    , bottom = 1
                                    , left = 0
                                    }
                                    ++ [ width fill
                                       , height (px 64)
                                       ]
                                )
                                [ el [ centerX ] (text e) ]
                        )
                )
            , row
                (Style.Basic.boundaryBorderEach
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
                [ paragraph
                    (Style.Home.userAvatarInTopBar ++ [ width (px 64) ])
                    [ text (userName model.me) ]
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
                                (text "这里是分类描述")
                            ]
                        ]
                    , row
                        [ width fill
                        , paddingXY 8 0
                        , spacing 8
                        ]
                        (([ "待办 (20)", "知识 (10)", "疑问 (5)" ]
                            |> List.map
                                (\t ->
                                    Input.button
                                        [ alignRight
                                        ]
                                        { onPress = Just Msg.NoOp
                                        , label = text t
                                        }
                                )
                         )
                            ++ [ el
                                    (Style.Basic.boundaryBorderEach
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
                                    Model.Icon.FilterOutlined
                               ]
                        )
                    ]
                , el
                    [ width fill
                    , height fill
                    , scrollbarY
                    ]
                    (View.Topic.ListView.create model)
                , column
                    (Style.Basic.boundaryBorderEach
                        { top = 1
                        , right = 0
                        , bottom = 0
                        , left = 0
                        }
                        ++ [ width fill
                           , height (px 224)
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
                                        { onPress = Just Msg.NoOp
                                        , label = text t
                                        }
                                )
                         )
                            ++ [ Input.button
                                    [ alignRight
                                    ]
                                    { onPress = Just Msg.NoOp
                                    , label = text "实时预览"
                                    }
                               ]
                        )
                    , column
                        (Style.Basic.boundaryBorderAll 1
                            ++ [ width fill
                               , height fill
                               , Border.rounded 3
                               ]
                        )
                        [ Input.multiline
                            [ width fill
                            , height
                                (fill
                                    |> maximum 150
                                )
                            , Border.width 0

                            -- , padding 0
                            ]
                            { onChange = \_ -> Msg.NoOp
                            , text = "a\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\na\n"
                            , placeholder =
                                Just
                                    (Input.placeholder
                                        []
                                        (text "又有什么奇妙的想法呢？赶紧记下来吧 :)")
                                    )
                            , label = Input.labelHidden ""
                            , spellcheck = False
                            }
                        , column
                            [ width fill
                            , paddingXY 8 0
                            ]
                            [ el
                                (Style.Basic.boundaryBorderEach
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
                                (List.singleton (text "分类: ")
                                    ++ ([ "产品开发", "点滴(DianDi)", "功能设计" ]
                                            |> List.map
                                                (\t ->
                                                    text (t ++ " > ")
                                                )
                                       )
                                )
                            , paragraph
                                []
                                (List.singleton (text "标签: ")
                                    ++ ([ "待办", "知识", "疑问", "+" ]
                                            |> List.map
                                                (\t ->
                                                    text (t ++ " ")
                                                )
                                       )
                                )
                            , Input.button
                                [ alignRight
                                ]
                                { onPress = Just Msg.NoOp
                                , label = text "记下来！"
                                }
                            ]
                        ]
                    ]
                ]
            , column
                (Style.Basic.boundaryBorderEach
                    { top = 0
                    , right = 0
                    , bottom = 0
                    , left = 1
                    }
                    ++ [ width (px (128 * 3))
                       , height fill
                       ]
                )
                [ el
                    [ centerX
                    , centerY
                    ]
                    (text "这里是主题详情展示页，默认显示当前分类的信息")
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


icon : Model.Icon.Icon -> Element msg
icon =
    Icon.icon
        { size = 16
        , color = rgb255 6 126 213
        }


iconBtn :
    List (Attribute msg)
    -> msg
    -> Model.Icon.Icon
    -> Element msg
iconBtn attr onPress i =
    Input.button
        (attr
            ++ [ width (px 16)
               ]
        )
        { onPress = Just onPress
        , label = icon i
        }
