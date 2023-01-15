module Model exposing (Flags, init, sub, update)

import Browser.Navigation as Nav
import Http
import I18n.Lang
import I18n.Port
import Model.Remote as Remote
import Model.Remote.Auth as RemoteAuth
import Model.Remote.Msg as RemoteMsg
import Model.Remote.Topic as RemoteTopic
import Model.Remote.User as RemoteUser
import Model.Root
    exposing
        ( RemoteData(..)
        , RootModel
        , createTopicCategoryTree
        , createTopicTree
        )
import Model.User as User
import Msg
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


init : Flags -> Url.Url -> Nav.Key -> ( RootModel, Cmd Msg.Msg )
init flags url key =
    { title = flags.title
    , description = flags.description

    --
    , lang =
        I18n.Lang.fromStringWithDefault
            View.I18n.Default.lang
            flags.lang
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


sub : RootModel -> Sub Msg.Msg
sub _ =
    Sub.batch
        [ I18n.Port.sub Msg.I18nPorts
        ]


update : Msg.Msg -> RootModel -> ( RootModel, Cmd Msg.Msg )
update msg model =
    case msg of
        Msg.RemoteFetched remoteMsg ->
            remoteUpdateHelper remoteMsg model

        Msg.UrlChanged url ->
            routeUpdateHelper url model

        Msg.I18nPorts i18nMsg ->
            i18nUpdateHelper i18nMsg model

        _ ->
            ( model, Cmd.none )



-- -------------------------------------------------------------------


{-| 远程请求更新
-}
remoteUpdateHelper :
    RemoteMsg.Msg
    -> RootModel
    -> ( RootModel, Cmd Msg.Msg )
remoteUpdateHelper msg model =
    case msg of
        RemoteMsg.GotMyUserInfo result ->
            case result of
                Ok user ->
                    ( { model
                        | me = User.User user
                      }
                    , Cmd.batch
                        [ Msg.toRemoteCmd RemoteTopic.getMyAllTopics
                        , Msg.toRemoteCmd RemoteTopic.getMyAllCategories
                        ]
                    )

                Err _ ->
                    View.Route.gotoLogin model

        RemoteMsg.UserLogout _ ->
            View.Route.gotoLogin model

        RemoteMsg.QueryMyTopics result ->
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

        RemoteMsg.QueryMyTopicCategories result ->
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
remoteErrorUpdateHelper : Http.Error -> RootModel -> ( RootModel, Cmd Msg.Msg )
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


routeUpdateHelper : Url.Url -> RootModel -> ( RootModel, Cmd Msg.Msg )
routeUpdateHelper url model =
    let
        ( page, cmd ) =
            case View.Route.route url of
                View.Route.Login ->
                    ( PageType.Login, Cmd.none )

                View.Route.Logout ->
                    ( PageType.Login, Msg.toRemoteCmd RemoteAuth.logout )

                View.Route.Home ->
                    ( PageType.Home, Msg.toRemoteCmd RemoteUser.getMyUserInfo )

                View.Route.Forbidden ->
                    ( PageType.Forbidden, Cmd.none )

                View.Route.NotFound ->
                    ( PageType.NotFound, Cmd.none )
    in
    ( { model | currentPage = page, navUrl = url }, cmd )


i18nUpdateHelper : I18n.Port.Msg -> RootModel -> ( RootModel, Cmd Msg.Msg )
i18nUpdateHelper msg model =
    case I18n.Port.update msg of
        ( r, m ) ->
            ( { model | textsWithoutI18n = r.results }, m )
