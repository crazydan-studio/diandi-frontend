module Model.Root exposing (RootModel)

import Browser.Navigation as Nav
import I18n.Lang exposing (Lang)
import Model.Topic
import Model.User as User
import Url
import View.Type


type alias RootModel =
    { title : String
    , description : String
    , lang : Lang
    , navKey : Nav.Key
    , navUrl : Url.Url

    -- 当前用户信息
    , me : User.User

    -- 远程请求错误信息
    , remoteError : Maybe String
    , currentPage : View.Type.Type

    --
    , topics : List Model.Topic.Topic
    }
