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


module I18n.Translator exposing
    ( TextsNeedToBeTranslated
    , TranslateResult(..)
    , Translator
    , default
    , defaultWith
    , modulesFromString
    , modulesToString
    , ok
    , textsToString
    , translate
    )

import I18n.Lang exposing (Lang(..))
import String exposing (startsWith)


type alias Translator =
    List String -> List ( Lang, TranslateResult )


type TranslateResult
    = Translated String
    | WaitingToTranslate TextsNeedToBeTranslated


type alias TextsNeedToBeTranslated =
    { lang : Lang
    , modules : List String
    , texts : List String
    }


ok : Lang -> String -> ( Lang, TranslateResult )
ok lang text =
    ( lang, Translated text )


default : List ( Lang, TranslateResult )
default =
    []


defaultWith : List String -> List ( Lang, TranslateResult )
defaultWith texts =
    [ ( Default
      , WaitingToTranslate
            { lang = Default
            , modules = []
            , texts = texts
            }
      )
    ]


modulesToString : List String -> String
modulesToString =
    String.join "/"


modulesFromString : String -> List String
modulesFromString =
    String.split "/"


textsToString : List String -> String
textsToString =
    String.join ""


translate :
    -- 待翻译文本的源语言
    Lang
    -- 待翻译文本的目标语言
    -> Lang
    -- 待翻译文本。变量作为list元素，最终直接将元素拼接在一起
    -> List String
    -- List (modules, translator)
    -> List ( List String, Translator )
    -> TranslateResult
translate sourceLang lang texts translators =
    case doTranslate lang texts translators of
        Translated r ->
            Translated r

        WaitingToTranslate r ->
            if sourceLang == r.lang then
                Translated (textsToString r.texts)

            else
                WaitingToTranslate r


doTranslate :
    Lang
    -> List String
    -- List (modules, translator)
    -> List ( List String, Translator )
    -> TranslateResult
doTranslate lang texts translators =
    case translators of
        [] ->
            WaitingToTranslate
                { lang = lang
                , modules = []
                , texts = texts
                }

        ( modules, translator ) :: leftTranslators ->
            case callTranslator modules translator texts of
                Nothing ->
                    doTranslate lang texts leftTranslators

                Just results ->
                    matchTranslatorResults lang modules texts results


callTranslator :
    List String
    -> Translator
    -> List String
    -> Maybe (List ( Lang, TranslateResult ))
callTranslator modules translator texts =
    if startsWith modules texts then
        Just
            (translator (dropModules modules texts))

    else
        Nothing


matchTranslatorResults :
    Lang
    -> List String
    -> List String
    -> List ( Lang, TranslateResult )
    -> TranslateResult
matchTranslatorResults lang modules texts results =
    case results of
        [] ->
            WaitingToTranslate
                { lang = lang
                , modules = modules
                , texts = dropModules modules texts
                }

        [ ( Default, WaitingToTranslate r ) ] ->
            WaitingToTranslate
                { r
                    | lang = lang
                    , modules = modules
                }

        ( lng, result ) :: leftResults ->
            if lng == lang then
                result

            else
                matchTranslatorResults lang
                    modules
                    texts
                    leftResults


startsWith : List String -> List String -> Bool
startsWith modules texts =
    case modules of
        [] ->
            True

        m_ :: subModules ->
            case texts of
                [] ->
                    False

                t_ :: leftTexts ->
                    if m_ == t_ then
                        startsWith subModules leftTexts

                    else
                        False


dropModules : List String -> List String -> List String
dropModules modules texts =
    texts
        |> List.drop (List.length modules)
