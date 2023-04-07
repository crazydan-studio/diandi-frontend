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


module Model.I18n.App exposing (translate)

import I18n.Lang exposing (Lang(..))
import I18n.Translator as Translator
    exposing
        ( TranslateResult
        , default
        , ok
        )


translate : Lang -> List String -> TranslateResult
translate lang texts =
    Translator.translate Zh_CN lang texts <|
        [ ( [], translator )
        ]


translator : List String -> List ( Lang, TranslateResult )
translator texts =
    case texts of
        [ "主题内容是空白的，请先输入点什么" ] ->
            ok En_US "The user is not authorized"
                :: default

        _ ->
            default
