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
view ({ app } as state) =
    let
        paddingX =
            if
                app.device.class
                    == Phone
                    && app.device.orientation
                    == Portrait
            then
                BaseStyle.spacing8x

            else
                BaseStyle.spacing8x * 2
    in
    el
        [ width fill
        , height fill
        , inFront
            (el
                [ width (px paddingX)
                , height fill
                , alignRight
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
tools ({ app, theme, widgets, withI18nElement } as state) =
    let
        i18nText =
            withI18nElement I18n.text
    in
    column
        [ spacing BaseStyle.spacing
        , centerX
        , centerY
        ]
        [ widgets.with <|
            Button.circle
                { attrs =
                    theme.primaryBtn
                        ++ [ centerX ]
                , content =
                    if
                        app.device.class
                            == Phone
                            && app.device.orientation
                            == Portrait
                    then
                        el [ centerX ]
                            (theme.primaryBtnIcon
                                { icon = Icon.FormOutlined, size = Just 15 }
                            )

                    else
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
                        (Msg.batch
                            [ Msg.NewTopicPending
                            , Msg.ShowPageLayer Page.NewTopicLayer
                            ]
                        )
                }
        ]
