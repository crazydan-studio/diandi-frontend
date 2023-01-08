module View.Home exposing (create)

import Element exposing (..)
import Element.Font as Font
import Model.Root exposing (RootModel)
import Model.User
import Msg exposing (RootMsg)
import Style.Basic
import Style.Home
import View.Topic.ListView


create : RootModel -> Element RootMsg
create model =
    row
        [ width fill
        , height fill
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
                   , clip
                   ]
            )
            [ row
                Style.Home.topBar
                [ image
                    (Style.Home.logoInTopBar ++ [ alignLeft ])
                    { src = "/logo.svg", description = "" }

                -- TODO 点击后向左展开输入框，失焦后还原
                , el
                    [ alignRight
                    ]
                    (text "搜索")
                ]
            , row
                (Style.Basic.boundaryBorderEach
                    { top = 0
                    , right = 0
                    , bottom = 1
                    , left = 0
                    }
                    ++ [ width fill
                       , height shrink
                       , padding 8
                       ]
                )
                [ el
                    [ alignLeft
                    ]
                    (text "返回")
                , el
                    [ alignRight
                    ]
                    (text "添加")
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

            -- for child scrollbar: https://github.com/mdgriffith/elm-ui/issues/149#issuecomment-582229271
            , clip
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
                    [ el
                        [ width fill
                        , height shrink
                        , centerY
                        , Font.size 20
                        ]
                        (text "点滴")
                    , paragraph
                        [ width shrink
                        , height shrink
                        , alignRight
                        ]
                        [ paragraph
                            []
                            ([ "待办 (20)", "知识 (10)", "疑问 (5)" ]
                                |> List.map
                                    (\e ->
                                        el [ paddingXY 8 0 ] (text e)
                                    )
                            )
                        , el
                            (Style.Basic.boundaryBorderEach
                                { top = 0
                                , right = 1
                                , bottom = 0
                                , left = 0
                                }
                                ++ [ width fill
                                   , height fill
                                   ]
                            )
                            none
                        , el [ paddingXY 8 0 ] (text "过滤")
                        ]
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
                           , height (px (128 * 1))
                           , padding 8
                           ]
                    )
                    []
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
