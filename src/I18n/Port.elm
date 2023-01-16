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

port module I18n.Port exposing
    ( Msg
    , find
    , findNotTranslatedTexts
    , getNotTranslatedTexts
    , sub
    , update
    )

{-| 通过JS获取未国际化文本

实现参考: <https://guide.elm-lang.org/interop/ports.html>

-}

import I18n.Helper exposing (splitI18nModulesFrom)
import I18n.Lang exposing (TextsNeedToBeTranslated)


type Msg
    = FindNotTranslatedTexts
    | GotNotTranslatedTexts (List NotTranslatedText)


type alias NotTranslatedText =
    { modules : String
    , text : String
    }


{-| 查找未国际化的文本

从Elm触发JS调用

-}
port findNotTranslatedTexts : () -> Cmd msg


{-| 获取未国际化的文本

从JS触发Elm消息

-}
port getNotTranslatedTexts : (List NotTranslatedText -> msg) -> Sub msg


find : (Msg -> msg) -> msg
find toMsg =
    toMsg FindNotTranslatedTexts


{-| 订阅 获取到未国际化文本 的消息
-}
sub : (Msg -> msg) -> Sub msg
sub toMsg =
    getNotTranslatedTexts
        (\results ->
            toMsg (GotNotTranslatedTexts results)
        )


{-| 消息更新
-}
update :
    Msg
    ->
        ( { results : List TextsNeedToBeTranslated
          }
        , Cmd msg
        )
update msg =
    case msg of
        FindNotTranslatedTexts ->
            ( { results = [] }, findNotTranslatedTexts () )

        GotNotTranslatedTexts results ->
            ( { results =
                    results
                        |> List.map
                            (\r ->
                                { modules = splitI18nModulesFrom r.modules
                                , texts = [ r.text ]
                                }
                            )
              }
            , Cmd.none
            )
