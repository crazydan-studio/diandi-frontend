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


module View.I18n.Default exposing
    ( translator
    , lang
    )

import I18n.Helper exposing (translateWaitingByLang)
import I18n.Lang exposing (Lang, TranslateResult)


{-| 待翻译文本自身的语言类型
-}
lang : Lang
lang =
    I18n.Lang.Zh_CN


{-| 根据代码中的默认语言确定返回结果是否为无需翻译或待翻译
-}
translator :
    Lang
    -> List String
    -> List String
    -> TranslateResult
translator langType modules =
    translateWaitingByLang
        { default = lang
        , current = langType
        }
        modules
