module View.Page.Home.Center exposing (view)

import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import I18n.I18n exposing (langTextEnd)
import Model
import Msg
import View.I18n.Home as I18n
import View.Page.Topic.List as TopicList
import View.Style.Base as BaseStyle
import Widget.Animation.Transition as Transition
import Widget.Icon as Icon
import Widget.Widget.Button as Button
import Widget.Widget.PageLayer as PageLayer


view : Model.State -> Element Msg.Msg
view state =
    let
        paddingX =
            BaseStyle.spacing8x * 2
    in
    el
        [ width fill
        , height fill
        , inFront
            (el
                [ alignRight
                , centerY
                , moveLeft (toFloat paddingX / 2 - 40)
                ]
                (tools state)
            )

        -- for child scrollbar: https://github.com/mdgriffith/elm-ui/issues/149#issuecomment-582229271
        , clip
        ]
        (el
            [ width fill
            , height fill
            , scrollbarY
            , paddingXY paddingX BaseStyle.spacing3x
            ]
            (TopicList.view state)
        )


tools : Model.State -> Element Msg.Msg
tools ({ theme, widgets, withI18nElement } as state) =
    let
        i18nText =
            withI18nElement I18n.text
    in
    column
        [ spacing BaseStyle.spacing
        ]
        [ widgets.with <|
            Button.circle
                { attrs = theme.primaryBtn ++ [ centerX ]
                , content =
                    column
                        [ width (px 40)
                        , height (px 40)
                        , spacing BaseStyle.spacing
                        ]
                        [ el [ centerX ]
                            (theme.primaryBtnIcon
                                { icon = Icon.FormOutlined, size = Just 20 }
                            )
                        , el
                            [ centerX
                            , Font.size theme.secondaryFontSize
                            ]
                            ((I18n.buttonText :: "新增" :: langTextEnd)
                                |> i18nText
                            )
                        ]
                , onPress =
                    Just
                        (widgets.on <|
                            PageLayer.show (newTopicWindow state)
                        )
                }
        ]


newTopicWindow : Model.State -> Element Msg.Msg
newTopicWindow { theme, widgets, withI18nElement } =
    let
        i18nText =
            withI18nElement I18n.text
    in
    column
        (theme.primaryWhiteBackground
            ++ [ height fill
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
                ++ [ id "xxxx"
                   , width fill
                   , height (px 42)
                   ]
            )
            { onChange =
                \text ->
                    Msg.NoOp
            , text = ""
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
        , Input.multiline
            (theme.defaultInput
                ++ [ id "xxxx"
                   , width fill
                   , height fill
                   ]
            )
            { onChange =
                \text ->
                    Msg.NoOp
            , text = ""
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
        , row
            [ width fill
            ]
            [ el [ alignTop ]
                ((I18n.labelText :: "标签：" :: langTextEnd)
                    |> i18nText
                )
            , wrappedRow
                [ width fill
                ]
                [ Input.text
                    (theme.defaultInput
                        ++ [ id "xxxx"
                           , height (px 42)
                           ]
                    )
                    { onChange =
                        \text ->
                            Msg.NoOp
                    , text = ""
                    , selection = Nothing
                    , placeholder = Nothing
                    , label = Input.labelHidden ""
                    }
                ]
            ]
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
                    , onPress = Nothing
                    }
            , widgets.with <|
                Button.button
                    { attrs = theme.secondaryBtn ++ []
                    , content =
                        (I18n.buttonText :: "取消" :: langTextEnd)
                            |> i18nText
                    , onPress =
                        Just
                            (widgets.on <|
                                PageLayer.close
                            )
                    }
            ]
        ]
