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


module Widget.Bytemd exposing (viewer)

import Html exposing (Attribute, Html, node)
import Html.Attributes exposing (class, value)


viewer : List (Attribute msg) -> String -> Html msg
viewer attrs md =
    node "bytemd-viewer"
        (attrs
            ++ [ value md

               -- https://tailwindcss.com/docs/typography-plugin
               , class "prose dark:prose-invert leading-6"
               , class "prose-ul:my-0"
               , class "prose-ol:my-0"
               , class "prose-li:my-1"
               , class "prose-img:my-1"
               , class "prose-p:my-2"
               , class "prose-blockquote:my-2"
               , class "prose-pre:my-2"
               , class "prose-table:my-2 tr-nth-[even]:bg-slate-50 dark:tr-nth-[even]:bg-slate-800"
               , class "prose-h1:mb-3"
               , class "prose-h2:mb-3 prose-h2:mt-6"
               , class "prose-h3:mt-6"
               , class "prose-h4:mt-6"
               , class "prose-code:before:content-[''] prose-code:after:content-[''] prose-code:px-1.5 prose-code:py-0.5 prose-code:rounded-lg prose-code:text-sm prose-code:bg-gray-100 dark:prose-code:bg-slate-700"
               ]
        )
        []
