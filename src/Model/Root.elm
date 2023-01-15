module Model.Root exposing
    ( RemoteData(..)
    , RootModel
    , createTopicCategoryTree
    , createTopicTree
    )

import Browser.Navigation as Nav
import Data.TreeStore
import I18n.Lang exposing (Lang, TextsNeedToBeTranslated)
import Model.Topic exposing (Topic)
import Model.Topic.Category exposing (Category)
import Model.User as User
import Theme.Theme
import Url
import View.Page


type alias RootModel =
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
    , topics : RemoteData (Data.TreeStore.Tree Topic)
    , categories : RemoteData (Data.TreeStore.Tree Category)
    }


type RemoteData dataType
    = DataLoaded dataType
    | DataLoading
    | DataLoadingError String


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
