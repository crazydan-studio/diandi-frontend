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


module Model.Remote.Demo.Topic exposing
    ( getMyAllCategories
    , getMyAllTopics
    , queryMyCategories
    , queryMyTopics
    )

import Http
import Json.Decode as Decode
import Model.Remote.Msg exposing (Msg(..))
import Model.Topic exposing (Topic, topicListDecoder)
import Model.Topic.Category exposing (categoryListDecoder)


getMyAllTopics : Cmd Msg
getMyAllTopics =
    queryMyTopics
        { category = Nothing
        }


queryMyTopics :
    { category : Maybe String
    }
    -> Cmd Msg
queryMyTopics params =
    Http.get
        { url = "/demo/topics.json"
        , expect =
            Http.expectJson QueryMyTopics
                (decoderWithFilterTopicsByCategory params.category)
        }


getMyAllCategories : Cmd Msg
getMyAllCategories =
    queryMyCategories {}


queryMyCategories : {} -> Cmd Msg
queryMyCategories _ =
    Http.get
        { url = "/demo/categories.json"
        , expect = Http.expectJson QueryMyTopicCategories categoryListDecoder
        }



-- ----------------------------------------------


decoderWithFilterTopicsByCategory :
    Maybe String
    -> Decode.Decoder (List Topic)
decoderWithFilterTopicsByCategory categoryMaybe =
    let
        listFilter category =
            List.filter
                (\topic ->
                    topic.category
                        |> Maybe.map
                            (String.startsWith category)
                        |> Maybe.withDefault False
                )
    in
    categoryMaybe
        |> Maybe.map
            (\category ->
                topicListDecoder
                    |> Decode.map (listFilter category)
            )
        |> Maybe.withDefault topicListDecoder
