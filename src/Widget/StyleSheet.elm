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


module Widget.StyleSheet exposing (create)

import Html exposing (Html)


create : Html msg
create =
    Html.node "style"
        []
        [ -- 解决原始的 .s.r > .s 选择的文本宽度始终为0的问题
          Html.text
            (([ ".s.r > .s.wp-btn"
              , ".wp-btn > .s.r > .s"
              ]
                |> String.join ","
             )
                ++ " {flex-basis: auto;}"
            )
        ]