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
import Element.Input as Input
import I18n.I18n exposing (langTextEnd)
import Model
import Msg
import Random
import View.I18n.Home as I18n
import View.Style.Base as BaseStyle
import View.Style.Border.Primary as PrimaryBorder
import Widget.Html exposing (class)
import Widget.Icon as Icon
import Widget.Widget.Button as Button


view : Model.State -> Element Msg.Msg
view ({ app, theme, withWidgetContext, withI18nElement } as state) =
    let
        i18nText =
            withI18nElement I18n.text

        headerPaddingY =
            BaseStyle.spacing

        headerHeight =
            40 + headerPaddingY * 2

        logoHeight =
            headerHeight - headerPaddingY * 2
    in
    column
        (theme.primaryGreyBackground
            ++ [ width fill
               , height fill

               -- for child scrollbar: https://github.com/mdgriffith/elm-ui/issues/149#issuecomment-582229271
               , clip
               ]
        )
        [ row
            (PrimaryBorder.bottom 1 theme
                ++ [ width fill
                   , height (px headerHeight)
                   , paddingXY
                        BaseStyle.spacing2x
                        headerPaddingY
                   ]
            )
            [ image
                [ width shrink
                , height (px logoHeight)
                , alignLeft
                ]
                { src = "/logo.svg", description = "", onLoad = Nothing }
            , el
                [ width (px 256)
                , height (px headerHeight)
                , centerX
                , centerY
                ]
                (Input.text
                    [ width fill
                    ]
                    { onChange = \t -> Msg.NoOp
                    , text = ""
                    , placeholder = Just (Input.placeholder [] (text "Search ..."))
                    , label = Input.labelHidden ""
                    , selection = Nothing
                    }
                )
            , withWidgetContext <|
                Button.button
                    { id = "btn-personal-setting-in-home"
                    , attrs = theme.secondaryBtn
                    , content =
                        row
                            [ spacing BaseStyle.spacing
                            ]
                            [ theme.primaryBtnIcon
                                Icon.SettingOutlined
                            , -- TODO 点击后，在左侧弹出侧边栏，该侧边栏中展示用户头像/名称、语言切换、主题切换等
                              (I18n.buttonText :: "设置" :: langTextEnd)
                                |> i18nText
                            ]
                    , onPress = Nothing
                    }
            ]
        , el
            [ width fill
            , height fill
            , scrollbarY
            , paddingXY 256 64
            ]
            (wrappedRow
                [ spaceEvenly
                ]
                (List.range 1 20
                    |> List.map
                        (\idx ->
                            let
                                ( cardRotateDeg, _ ) =
                                    Random.step (Random.float 0 1) (Random.initialSeed idx)

                                ( pushpinPosition, _ ) =
                                    Random.step (Random.float 0 120) (Random.initialSeed idx)
                            in
                            card (cardRotateDeg * 10 + -5) pushpinPosition
                        )
                )
            )
        ]


card : Float -> Float -> Element Msg.Msg
card cardRotateDeg pushpinPosition =
    el
        [ inFront
            (image
                [ width shrink
                , height (px 32)
                , alignTop
                , moveRight (60.0 + pushpinPosition)
                ]
                { src = "/img/pushpin.svg", description = "", onLoad = Nothing }
            )
        ]
        (column
            [ width (px 240)
            , height (px 172)
            , padding 24
            , class "card"
            , clip
            , htmlStyleAttribute
                [ ( "transform"
                  , "rotate(" ++ String.fromFloat cardRotateDeg ++ "deg)"
                  )
                ]
            ]
            [ el
                [ width fill
                , height fill
                , scrollbarY
                ]
                (paragraph []
                    [ text "编写完后，以顺滑的方式选择主题分类，从而完成对主题的保存和组织"
                    , text "编写完后，以顺滑的方式选择主题分类，从而完成对主题的保存和组织"
                    , text "编写完后，以顺滑的方式选择主题分类，从而完成对主题的保存和组织"
                    , text "编写完后，以顺滑的方式选择主题分类，从而完成对主题的保存和组织"
                    , text "编写完后，以顺滑的方式选择主题分类，从而完成对主题的保存和组织"
                    , text "编写完后，以顺滑的方式选择主题分类，从而完成对主题的保存和组织"
                    , text "编写完后，以顺滑的方式选择主题分类，从而完成对主题的保存和组织"
                    , text "编写完后，以顺滑的方式选择主题分类，从而完成对主题的保存和组织"
                    ]
                )
            ]
        )
