module Model exposing (Flags, init, sub, update)

import Browser.Navigation as Nav
import Http
import I18n.Lang
import I18n.Port
import Model.Root
    exposing
        ( RemoteData(..)
        , RootModel
        , createTopicCategoryTree
        , createTopicTree
        )
import Model.User as User
import Msg exposing (..)
import Remote exposing (RemoteMsg)
import Theme.Type.Default
import Url
import View.I18n.Default
import View.Page as PageType
import View.Route


type alias Flags =
    { title : String
    , description : String
    , lang : String
    }


init : Flags -> Url.Url -> Nav.Key -> ( RootModel, Cmd RootMsg )
init flags url key =
    { title = flags.title
    , description = flags.description

    --
    , lang = I18n.Lang.fromStringWithDefault View.I18n.Default.lang flags.lang
    , textsWithoutI18n = []
    , theme = Theme.Type.Default.theme

    --
    , navKey = key
    , navUrl = url

    --
    , me = User.None
    , remoteError = Nothing
    , currentPage = PageType.Loading

    --
    , topics = DataLoading
    , categories = DataLoading
    }
        |> routeUpdateHelper url


sub : RootModel -> Sub RootMsg
sub _ =
    Sub.batch
        [ I18n.Port.sub I18nPorts
        ]


update : RootMsg -> RootModel -> ( RootModel, Cmd RootMsg )
update msg model =
    case msg of
        RemoteFetched remoteMsg ->
            remoteUpdateHelper remoteMsg model

        UrlChanged url ->
            routeUpdateHelper url model

        I18nPorts i18nMsg ->
            i18nUpdateHelper i18nMsg model

        _ ->
            ( model, Cmd.none )



-- -------------------------------------------------------------------


{-| 发起远程请求
-}
remote : Cmd RemoteMsg -> Cmd RootMsg
remote msg =
    Cmd.map RemoteFetched msg


{-| 远程请求更新
-}
remoteUpdateHelper : RemoteMsg -> RootModel -> ( RootModel, Cmd RootMsg )
remoteUpdateHelper msg model =
    case msg of
        Remote.GotMyUserInfo result ->
            case result of
                Ok user ->
                    ( { model
                        | me = User.User user
                      }
                    , Cmd.batch
                        [ remote Remote.getAllMyTopics
                        , remote Remote.getAllMyTopicCategories
                        ]
                    )

                Err _ ->
                    View.Route.gotoLogin model

        Remote.UserLogout _ ->
            View.Route.gotoLogin model

        Remote.QueryMyTopics result ->
            case result of
                Ok topics ->
                    ( { model
                        | topics = DataLoaded (createTopicTree topics)
                      }
                    , Cmd.none
                    )

                Err error ->
                    ( { model
                        | topics = DataLoadingError (Remote.parseError error)
                      }
                    , Cmd.none
                    )

        Remote.QueryMyTopicCategories result ->
            case result of
                Ok categories ->
                    ( { model
                        | categories = DataLoaded (createTopicCategoryTree categories)
                      }
                    , Cmd.none
                    )

                Err error ->
                    ( { model
                        | categories = DataLoadingError (Remote.parseError error)
                      }
                    , Cmd.none
                    )

        _ ->
            ( model, Cmd.none )


{-| 远程请求异常的统一处理
-}
remoteErrorUpdateHelper : Http.Error -> RootModel -> ( RootModel, Cmd RootMsg )
remoteErrorUpdateHelper error model =
    case error of
        Http.BadStatus status ->
            if status == 401 then
                View.Route.gotoLogin model

            else if status == 403 then
                View.Route.goto403 model

            else if status == 404 then
                View.Route.goto404 model

            else
                ( model, Cmd.none )

        _ ->
            ( { model
                | remoteError = Just (Remote.parseError error)
              }
            , Cmd.none
            )


routeUpdateHelper : Url.Url -> RootModel -> ( RootModel, Cmd RootMsg )
routeUpdateHelper url model =
    let
        ( page, cmd ) =
            case View.Route.route url of
                View.Route.Login ->
                    ( PageType.Login, Cmd.none )

                View.Route.Logout ->
                    ( PageType.Login, remote Remote.logout )

                View.Route.Home ->
                    ( PageType.Home, remote Remote.getMyUserInfo )

                View.Route.Forbidden ->
                    ( PageType.Forbidden, Cmd.none )

                View.Route.NotFound ->
                    ( PageType.NotFound, Cmd.none )
    in
    ( { model | currentPage = page, navUrl = url }, cmd )


i18nUpdateHelper : I18n.Port.Msg -> RootModel -> ( RootModel, Cmd RootMsg )
i18nUpdateHelper msg model =
    case I18n.Port.update msg of
        ( r, m ) ->
            ( { model | textsWithoutI18n = r.results }, m )
