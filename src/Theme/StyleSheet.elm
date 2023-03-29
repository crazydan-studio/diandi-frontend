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


module Theme.StyleSheet exposing (create)

import Html exposing (Html)
import Model
import Widget.Html exposing (template)


create : Model.State -> Html msg
create ({ app, theme } as state) =
    Html.node "style"
        []
        [ -- 隐藏加载动画，显示 body 下的元素
          Html.text """
body::after { opacity: 0; }
body > * { opacity: 1; }
"""

        -- 主题卡片宽度自适应设置：根据每行显示的卡片数量确定其最小宽度
        , Html.text
            ("""
.topic-card.size-fit {
  min-width: calc((100% - 16px * {{topic_card_count}}) / {{topic_card_count}}) !important;
}
"""
                |> template
                    [ ( "topic_card_count", "5" )
                    ]
            )
        ]
