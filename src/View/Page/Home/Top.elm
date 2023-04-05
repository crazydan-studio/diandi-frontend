module View.Page.Home.Top exposing (..)

import Element exposing (..)
import Element.Border as Border
import Element.Events exposing (onEnter)
import Element.Input as Input
import I18n.I18n exposing (langTextEnd)
import Model
import Msg
import View.I18n.Home as I18n
import View.Style.Base as BaseStyle
import View.Style.Border.Primary as PrimaryBorder
import Widget.Icon as Icon
import Widget.Widget.Button as Button


view : Model.State -> Element Msg.Msg
view ({ app, theme, widgets, withI18nElement } as state) =
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
    row
        (PrimaryBorder.bottom 1 theme
            ++ theme.primaryWhiteBackground
            ++ [ width fill
               , height (px headerHeight)
               , paddingXY
                    BaseStyle.spacing2x
                    headerPaddingY
               , zIndex 2

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
        )
        [ image
            [ width shrink
            , height (px logoHeight)
            , alignLeft
            ]
            { src =
                if
                    app.device.class
                        == Phone
                        && app.device.orientation
                        == Portrait
                then
                    "/icon.svg"

                else
                    "/logo.svg"
            , description = ""
            , onLoad = Nothing
            }
        , row
            [ width
                (percent 30
                    |> minimum 215
                )
            , centerX
            , Border.width 1
            , Border.color theme.primaryBorderColor
            , Border.rounded 32
            , paddingXY BaseStyle.spacing2x 0
            ]
            [ Icon.icon
                { size = 20
                , color = theme.primaryFontColor
                , icon = Icon.SearchOutlined
                }
            , Input.text
                [ width fill
                , Border.width 0
                , theme.transparentBackground
                , onEnter Msg.SearchTopic
                ]
                { onChange = Msg.SearchTopicInputing
                , text =
                    app.topicSearchingText
                        |> Maybe.withDefault ""
                , placeholder =
                    Just
                        (Input.placeholder []
                            (("请输入关键字查询 ..." :: langTextEnd)
                                |> i18nText
                            )
                        )
                , label = Input.labelHidden ""
                , selection = Nothing
                }
            ]
        , widgets.with <|
            Button.button
                { attrs = theme.secondaryBtn
                , content =
                    row
                        [ spacing BaseStyle.spacing
                        ]
                        [ theme.primaryBtnIcon
                            { icon = Icon.SettingOutlined, size = Nothing }
                        , -- TODO 点击后，在左侧弹出侧边栏，该侧边栏中展示用户头像/名称、语言切换、主题切换等
                          if
                            app.device.class
                                == Phone
                                && app.device.orientation
                                == Portrait
                          then
                            none

                          else
                            (I18n.buttonText :: "设置" :: langTextEnd)
                                |> i18nText
                        ]
                , onPress = Nothing
                }
        ]
