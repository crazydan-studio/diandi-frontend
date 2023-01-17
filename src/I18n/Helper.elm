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

module I18n.Helper exposing
    ( translateWaiting
    , translateWaitingByLang
    , joinI18nModules
    , joinI18nTexts
    , splitI18nModulesFrom
    )

import I18n.Lang exposing (Lang, TranslateResult(..))


{-| 拼接国际化文本
-}
joinI18nTexts : List String -> String
joinI18nTexts =
    String.join ""


{-| 拼接国际化模块
-}
joinI18nModules : List String -> String
joinI18nModules =
    String.join "/"


{-| 从字符串中拆分出国际化模块
-}
splitI18nModulesFrom : String -> List String
splitI18nModulesFrom =
    String.split "/"


{-| 返回结果[WaitingToTranslate](I18n.Lang#WaitingToTranslate)
-}
translateWaiting : List String -> List String -> TranslateResult
translateWaiting modules texts =
    WaitingToTranslate { modules = modules, texts = texts }


{-| 根据默认Lang和当前Lang确定结果是否为[WaitingToTranslate](I18n.Lang#WaitingToTranslate)

当前Lang与默认Lang相同时，返回`NoNeedsToTranslate`，否则，返回`WaitingToTranslate`

-}
translateWaitingByLang :
    { default : Lang, current : Lang }
    -> List String
    -> List String
    -> TranslateResult
translateWaitingByLang lang modules texts =
    if lang.current == lang.default then
        NoNeedsToTranslate texts

    else
        translateWaiting modules texts
