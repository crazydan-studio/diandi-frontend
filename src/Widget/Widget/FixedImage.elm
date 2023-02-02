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


module Widget.Widget.FixedImage exposing (image)

{-| 尺寸固定图片组件

可设置尺寸，未设置时，按图片自身尺寸设置

-}

import Element
    exposing
        ( Attribute
        , Element
        , Length
        , fill
        , height
        , px
        , width
        )
import Hex
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (required)
import Murmur3
import Widget.Internal.Widget.FixedImage as Internal
import Widget.Util.Hash exposing (hash)


type alias Config msg =
    { src : String
    , attrs : List (Attribute msg)
    , initWidth : Maybe Length
    , initHeight : Maybe Length
    , newWidth : Maybe (Int -> Int)
    , newHeight : Maybe (Int -> Int)
    }


type alias Context a msg =
    { a | fixedImageContext : Internal.Context msg }


type alias Size =
    { w : Int
    , h : Int
    }



-- 实现方案参考: https://ellie-app.com/3FCdcDqy4gqa1


image :
    Config msg
    -> Context a msg
    -> Element msg
image config { fixedImageContext } =
    createHelper fixedImageContext config



-- -----------------------------------------------------------


createHelper : Internal.Context msg -> Config msg -> Element msg
createHelper { getState, onUpdate } { src, attrs, initWidth, initHeight, newWidth, newHeight } =
    let
        id =
            hash src

        imageSize =
            case getState id of
                Just s ->
                    [ width (px (updateSize newWidth s.width))
                    , height (px (updateSize newHeight s.height))
                    ]

                Nothing ->
                    [ width
                        (initWidth
                            |> Maybe.withDefault fill
                        )
                    , height
                        (initHeight
                            |> Maybe.withDefault fill
                        )
                    ]

        updateSize updater size =
            case updater of
                Nothing ->
                    size

                Just u ->
                    u size
    in
    Element.image
        (imageSize ++ attrs)
        { src = src
        , description = ""
        , onLoad =
            Just
                (decodeImageLoad
                    (\size ->
                        onUpdate id
                            (\s ->
                                Just
                                    { s
                                        | width = size.w
                                        , height = size.h
                                    }
                            )
                    )
                )
        }


decodeImageLoad : (Size -> msg) -> Decoder msg
decodeImageLoad toMsg =
    Decode.succeed Size
        |> required "width" Decode.int
        |> required "height" Decode.int
        |> Decode.field "target"
        |> Decode.map toMsg
