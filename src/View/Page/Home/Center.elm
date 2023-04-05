module View.Page.Home.Center exposing (view)

import Element exposing (..)
import Element.Font as Font
import I18n.I18n exposing (langTextEnd)
import Model
import Msg
import View.I18n.Home as I18n
import View.Page as Page
import View.Page.Topic.List as TopicList
import View.Style.Base as BaseStyle
import Widget.Icon as Icon
import Widget.Widget.Button as Button


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
                        (Msg.ShowPageLayer Page.NewTopicLayer)
                }
        ]
