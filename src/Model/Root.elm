module Model.Root exposing (RootModel)

import Browser.Navigation as Nav
import Model.Card
import Model.User as User
import Page.Type
import Url


type alias RootModel =
    { title : String
    , description : String
    , lang : String
    , navKey : Nav.Key
    , navUrl : Url.Url

    -- 当前用户信息
    , me : User.User

    -- 远程请求错误信息
    , remoteError : Maybe String
    , currentPage : Page.Type.Type

    --
    , cards : List Model.Card.Card
    }
