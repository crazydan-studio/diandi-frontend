module Model.Remote.Topic exposing
    ( getMyAllCategories
    , getMyAllTopics
    , queryMyCategories
    , queryMyTopics
    )

import Http
import Model.Remote.Msg exposing (Msg(..))
import Model.Topic exposing (topicListDecoder)
import Model.Topic.Category exposing (categoryListDecoder)


getMyAllTopics : Cmd Msg
getMyAllTopics =
    queryMyTopics {}


queryMyTopics : {} -> Cmd Msg
queryMyTopics _ =
    Http.get
        { url = "/demo/topics.json"
        , expect = Http.expectJson QueryMyTopics topicListDecoder
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
