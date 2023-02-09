module View.Page.Home.Center exposing (view)

import Element exposing (..)
import Element.Border as Border
import Element.Events exposing (onFocus)
import Element.Font as Font
import Element.Input as Input
import I18n.I18n exposing (langTextEnd)
import Model
import Model.Operation.NewTopic as NewTopic exposing (NewTopic)
import Msg
import View.I18n.Home as I18n
import View.Page.Topic.List as TopicList
import View.Style.Base as BaseStyle
import View.Style.Border.Primary as PrimaryBorder
import Widget.Html exposing (onClickOutOfMe, onInputBlur, zIndex)
import Widget.Icon as Icon
import Widget.Widget.TextEditor as TextEditor


view : Model.State -> Element Msg.Msg
view state =
    column
        [ width fill
        , height fill
        ]
        [ header state
        , body state
        , bottom state
        ]


body : Model.State -> Element Msg.Msg
body ({ app, theme } as state) =
    el
        [ width fill
        , height fill

        -- for child scrollbar: https://github.com/mdgriffith/elm-ui/issues/149#issuecomment-582229271
        , clip
        ]
        (el
            (theme.primaryGreyBackground
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
header ({ app, theme, withI18nElement } as state) =
    let
        i18nText =
            withI18nElement I18n.text

        headerPaddingY =
            BaseStyle.spacing

        categoryIconSize =
            40

        categoryNameFontSize =
            18

        categoryDescFontSize =
            categoryNameFontSize - 8
    in
    row
        [ width fill
        , height
            (shrink
                |> minimum (categoryIconSize + headerPaddingY * 2)
            )
        , zIndex 1
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
                                (theme.primaryIcon
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
                                        (theme.placeholderFont
                                            ++ [ Font.size categoryDescFontSize
                                               ]
                                        )
                                        (("点击这里添加描述信息" :: langTextEnd)
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
                        (PrimaryBorder.right 1 theme
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
                                [ theme.primaryLinkBtnIcon
                                    Icon.ReadOutlined
                                , (I18n.buttonText :: "阅读模式" :: langTextEnd)
                                    |> i18nText
                                ]
                        }
                   ]
            )
        ]


bottom : Model.State -> Element Msg.Msg
bottom ({ app, theme } as state) =
    let
        inputId =
            app.newTopicInputId

        newTopic =
            Model.getNewTopicWithInit inputId state

        toMsg =
            Msg.NewTopicMsg inputId
    in
    column
        (PrimaryBorder.top 1 theme
            ++ [ width fill
               , padding BaseStyle.spacing
               , spacing BaseStyle.spacing
               ]
            ++ (if newTopic.focused then
                    [ onClickOutOfMe (toMsg NewTopic.InputFocusOut)
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
newTopicInput inputId newTopic { app, theme, withI18nElement, withWidgetContext } =
    let
        i18nText =
            withI18nElement I18n.text

        toMsg =
            Msg.NewTopicMsg inputId

        inputMinHeight =
            40

        inputMaxHeight =
            inputMinHeight * 4
    in
    [ column
        (PrimaryBorder.all 1 theme
            ++ [ width fill
               , height (px 100)
               , Border.rounded 3
               ]
        )
        [ withWidgetContext <|
            TextEditor.editor
                { id = "new-topic-editor"
                }
        ]
    ]
