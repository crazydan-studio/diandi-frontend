module Model.Remote.Msg exposing (Msg(..))

import Http
import Model.Topic exposing (Topic)
import Model.Topic.Category exposing (Category)
import Model.User exposing (UserInfo)


type Msg
    = NoOp
    | GotMyUserInfo (Result Http.Error UserInfo)
    | UserLogout (Result Http.Error ())
    | QueryMyTopics (Result Http.Error (List Topic))
    | QueryMyTopicCategories (Result Http.Error (List Category))
