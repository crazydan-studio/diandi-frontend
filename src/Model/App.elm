module Model.App exposing
    ( Config
    , State
    , init
    , loadTopicCategories
    , loadTopics
    , loading
    )

import Browser.Navigation as Nav
import Data.TreeStore
import Http
import I18n.Lang exposing (Lang, TextsNeedToBeTranslated)
import Model.Remote.Data as RemoteData
import Model.Topic exposing (Topic)
import Model.Topic.Category exposing (Category)
import Model.User as User
import Theme.Theme
import Theme.Type.Default
import Url
import View.I18n.Default
import View.Page


type alias State =
    { title : String
    , description : String

    -- 国际化
    , lang : Lang
    , textsWithoutI18n : List TextsNeedToBeTranslated
    , theme : Theme.Theme.Theme

    -- 路由
    , navKey : Nav.Key
    , navUrl : Url.Url

    -- 当前用户信息
    , me : User.User

    -- 远程请求错误信息
    , remoteError : Maybe String
    , currentPage : View.Page.Type

    -- 业务数据
    , topics : RemoteData.Status (Data.TreeStore.Tree Topic)
    , categories : RemoteData.Status (Data.TreeStore.Tree Category)
    }


type alias Config =
    { title : String
    , description : String
    , lang : String
    , navKey : Nav.Key
    , navUrl : Url.Url
    }


init : Config -> State
init config =
    { title = config.title
    , description = config.description

    --
    , lang =
        I18n.Lang.fromStringWithDefault
            View.I18n.Default.lang
            config.lang
    , textsWithoutI18n = []
    , theme = Theme.Type.Default.theme

    --
    , navKey = config.navKey
    , navUrl = config.navUrl

    --
    , me = User.None
    , remoteError = Nothing
    , currentPage = View.Page.Loading

    --
    , topics = RemoteData.LoadWaiting
    , categories = RemoteData.LoadWaiting
    }


loading : RemoteData.Status a
loading =
    RemoteData.Loading


loadTopics : Result Http.Error (List Topic) -> State -> State
loadTopics result state =
    { state
        | topics =
            result
                |> RemoteData.from createTopicTree
    }


loadTopicCategories : Result Http.Error (List Category) -> State -> State
loadTopicCategories result state =
    { state
        | categories =
            result
                |> RemoteData.from createTopicCategoryTree
    }



-- --------------------------------------------------------------------


createTopicTree : List Topic -> Data.TreeStore.Tree Topic
createTopicTree topics =
    Data.TreeStore.create
        { idGetter = .id
        , parentGetter = .superior
        , sorter = Nothing
        }
        topics


createTopicCategoryTree : List Category -> Data.TreeStore.Tree Category
createTopicCategoryTree categories =
    Data.TreeStore.create
        { idGetter = .id
        , parentGetter = .parent
        , sorter = Nothing
        }
        categories
