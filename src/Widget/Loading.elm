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


module Widget.Loading exposing
    ( ball
    , ripple
    )

import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes exposing (..)


type alias Config =
    { width : Int
    , height : Int
    }


ball : Config -> Html msg
ball config =
    --     -- https://loading.io/spinner/ball/-ball-circle-round-bounce-jump-reflex
    --     """
    -- <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="margin:auto;background:#fff;display:block;" width="200px" height="200px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">
    -- <circle cx="50" cy="23" r="13" fill="#e15b64">
    --   <animate attributeName="cy" dur="1s" repeatCount="indefinite" calcMode="spline" keySplines="0.45 0 0.9 0.55;0 0.45 0.55 0.9" keyTimes="0;0.5;1" values="23;77;23"></animate>
    -- </circle>
    -- </svg>
    --     """
    svg
        [ width (String.fromInt config.width)
        , height (String.fromInt config.height)
        , viewBox "0 0 100 100"
        ]
        [ circle
            [ cx "50"
            , cy "23"
            , r "13"
            , fill "#e15b64"
            ]
            [ animate
                [ attributeName "cy"
                , dur "1s"
                , repeatCount "indefinite"
                , calcMode "spline"
                , keySplines "0.45 0 0.9 0.55;0 0.45 0.55 0.9"
                , keyTimes "0;0.5;1"
                , values "23;77;23"
                ]
                []
            ]
        ]


ripple : Config -> Html msg
ripple config =
    -- https://loading.io/spinner/ripple/-ripple-circle-scale-round-radar-radio
    -- """
    -- <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="margin:auto;background:#fff;display:block;" width="200px" height="200px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">
    --   <circle cx="50" cy="50" r="0" fill="none" stroke="#e90c59" stroke-width="2">
    --     <animate attributeName="r" repeatCount="indefinite" dur="1s" values="0;40" keyTimes="0;1" keySplines="0 0.2 0.8 1" calcMode="spline" begin="0s"></animate>
    --     <animate attributeName="opacity" repeatCount="indefinite" dur="1s" values="1;0" keyTimes="0;1" keySplines="0.2 0 0.8 1" calcMode="spline" begin="0s"></animate>
    --   </circle>
    --   <circle cx="50" cy="50" r="0" fill="none" stroke="#46dff0" stroke-width="2">
    --     <animate attributeName="r" repeatCount="indefinite" dur="1s" values="0;40" keyTimes="0;1" keySplines="0 0.2 0.8 1" calcMode="spline" begin="-0.5s"></animate>
    --     <animate attributeName="opacity" repeatCount="indefinite" dur="1s" values="1;0" keyTimes="0;1" keySplines="0.2 0 0.8 1" calcMode="spline" begin="-0.5s"></animate>
    --   </circle>
    -- </svg>
    -- """
    svg
        [ width (String.fromInt config.width)
        , height (String.fromInt config.height)
        , viewBox "0 0 100 100"
        ]
        [ circle
            [ cx "50"
            , cy "50"
            , r "0"
            , fill "none"
            , stroke "#e90c59"
            , strokeWidth "2"
            ]
            [ animate
                [ attributeName "r"
                , repeatCount "indefinite"
                , dur "1s"
                , begin "0s"
                , calcMode "spline"
                , keySplines "0.2 0 0.8 1"
                , keyTimes "0;1"
                , values "0;40"
                ]
                []
            , animate
                [ attributeName "opacity"
                , repeatCount "indefinite"
                , dur "1s"
                , begin "0s"
                , calcMode "spline"
                , keySplines "0.2 0 0.8 1"
                , keyTimes "0;1"
                , values "1;0"
                ]
                []
            ]
        , circle
            [ cx "50"
            , cy "50"
            , r "0"
            , fill "none"
            , stroke "#46dff0"
            , strokeWidth "2"
            ]
            [ animate
                [ attributeName "r"
                , repeatCount "indefinite"
                , dur "1s"
                , begin "-0.5s"
                , calcMode "spline"
                , keySplines "0.2 0 0.8 1"
                , keyTimes "0;1"
                , values "0;40"
                ]
                []
            , animate
                [ attributeName "opacity"
                , repeatCount "indefinite"
                , dur "1s"
                , begin "-0.5s"
                , calcMode "spline"
                , keySplines "0.2 0 0.8 1"
                , keyTimes "0;1"
                , values "1;0"
                ]
                []
            ]
        ]
