module View.Page.Home.Center exposing (view)

import Element exposing (..)
import Element.Border as Border
import Element.Events as Event
import Element.Font as Font
import Element.Input as Input
import I18n.Lang exposing (langEnd)
import Json.Decode as Decode
import Model
import Model.Operation.NewTopic as NewTopic exposing (NewTopic)
import Msg
import Theme.Theme as Theme
import View.I18n.Home as I18n
import View.Page.Topic.List as TopicList
import View.Style.Base as BaseStyle
import View.Style.Border.Primary as PrimaryBorder
import Widget.Icon as Icon
import Widget.Part.Button as Button


view : Model.State -> Element Msg.Msg
view state =
    column
        [ width fill
        , height fill
        , paddingEach
            { top = headerHeight
            , left = 0
            , right = 0
            , bottom = 0
            }
        , inFront (header state)
        ]
        [ body state
        , bottom state
        ]


headerHeight : Int
headerHeight =
    56


body : Model.State -> Element Msg.Msg
body ({ app, widgets } as state) =
    el
        [ width fill
        , height fill

        -- for child scrollbar: https://github.com/mdgriffith/elm-ui/issues/149#issuecomment-582229271
        , clip

        -- , inFront
        --     (el
        --         [ centerY
        --         , alignRight
        --         -- 主题列表右侧间距 - 按钮宽度 - 浮动工具栏左侧间距
        --         , moveLeft (64 - 48 - 8)
        --         ]
        --         (Button.button widgets
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
                ++ [ id app.topicListViewId
                   , width fill
                   , height fill
                   , scrollbarY
                   , paddingXY
                        BaseStyle.spacing8x
                        BaseStyle.spacing2x
                   ]
            )
            (TopicList.view state)
        )


header : Model.State -> Element Msg.Msg
header ({ app, widgets } as state) =
    let
        i18nText =
            I18n.text app.lang

        headerPaddingY =
            BaseStyle.spacing

        categoryIconSize =
            headerHeight - headerPaddingY * 2

        categoryNameFontSize =
            18

        categoryDescFontSize =
            categoryNameFontSize - 8
    in
    row
        [ width fill
        , height (px headerHeight)
        , paddingXY BaseStyle.spacing2x headerPaddingY

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
            , spacing BaseStyle.spacing
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
                                        [ width (px categoryIconSize)
                                        ]
                                        { src = src
                                        , description = ""
                                        , onLoad = Nothing
                                        }
                                )
                            |> Maybe.withDefault
                                (app.theme
                                    |> Theme.primaryIcon
                                        categoryIconSize
                                        Icon.QuestionCircleOutlined
                                )
                        , column
                            [ spacing BaseStyle.spacing
                            ]
                            [ el
                                [ Font.size categoryNameFontSize
                                ]
                                (text category.name)
                            , category.description
                                |> Maybe.map
                                    (\desc ->
                                        el
                                            [ Font.size categoryDescFontSize
                                            ]
                                            (text desc)
                                    )
                                |> Maybe.withDefault
                                    (el
                                        (Theme.placeholderFont app.theme
                                            ++ [ Font.size categoryDescFontSize
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
            , paddingXY BaseStyle.spacing 0
            , spacing BaseStyle.spacing
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
                        (PrimaryBorder.right 1 app.theme
                            ++ [ height fill
                               , alignRight
                               ]
                        )
                        none
                   , Input.button
                        [ alignRight
                        ]
                        { onPress = Nothing
                        , label =
                            row
                                [ spacing 2
                                ]
                                [ app.theme
                                    |> Theme.primaryLinkBtnIcon
                                        Icon.FilterOutlined
                                ]
                        }
                   ]
            )
        ]


bottom : Model.State -> Element Msg.Msg
bottom ({ app } as state) =
    let
        inputId =
            app.newTopicInputId

        newTopic =
            Model.getNewTopicWithInit inputId state

        toMsg =
            Msg.NewTopicUpdateMsg inputId
    in
    column
        (PrimaryBorder.top 1 app.theme
            ++ [ width fill
               , padding BaseStyle.spacing
               , spacing BaseStyle.spacing
               ]
            ++ (if newTopic.focused then
                    [ Event.on "clickOutOfMe"
                        (Decode.succeed
                            (toMsg NewTopic.InputFocusOut)
                        )
                    ]

                else
                    []
               )
        )
        (newTopicInput
            inputId
            newTopic
            state
        )


newTopicInput :
    String
    -> NewTopic
    -> Model.State
    -> List (Element Msg.Msg)
newTopicInput inputId newTopic { app, widgets } =
    let
        i18nText =
            I18n.text app.lang

        toMsg =
            Msg.NewTopicUpdateMsg inputId

        inputMinHeight =
            40

        inputMaxHeight =
            inputMinHeight * 4
    in
    (if newTopic.focused then
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
        ]

     else
        []
    )
        ++ [ column
                (PrimaryBorder.all 1 app.theme
                    ++ [ width fill
                       , height fill
                       , Border.rounded 3
                       ]
                )
                (Input.multiline
                    ([ id inputId
                     , width fill
                     , height
                        (if newTopic.focused then
                            px inputMaxHeight

                         else
                            px inputMinHeight
                        )
                     , Border.width 0
                     ]
                        ++ (if newTopic.focused then
                                [ Event.on "blur"
                                    (Input.selectionDecoder
                                        |> Decode.map
                                            (\selection ->
                                                toMsg
                                                    (NewTopic.InputFocusBlur
                                                        selection
                                                    )
                                            )
                                    )
                                ]

                            else
                                [ Event.onFocus
                                    (toMsg NewTopic.InputFocusIn)
                                ]
                           )
                    )
                    { onChange =
                        \text ->
                            toMsg
                                (NewTopic.InputContentChanged text)
                    , text = newTopic.content
                    , selection = newTopic.selection
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
                    :: (if newTopic.focused then
                            [ column
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
                                , widgets
                                    |> Button.button
                                        { id = "btn-write-it-down-in-home"
                                        , attrs =
                                            Theme.primaryBtn app.theme
                                                ++ [ alignRight
                                                   ]
                                        , content =
                                            (I18n.btnModule :: "记下来!" :: langEnd)
                                                |> i18nText
                                        , onPress =
                                            Just
                                                (Msg.NewTopicAdded inputId)
                                        }
                                ]
                            ]

                        else
                            []
                       )
                )
           ]
