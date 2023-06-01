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


module App.State exposing
    ( Config
    , State
    , init
    , isEmptyTopicCards
    , sub
    , update
    )

import App.I18n.App as I18n
import App.Msg as Msg exposing (Msg)
import App.Operation as Operation
import App.Operation.CleanTopics as CleanTopics exposing (TopicsCleaner)
import App.Operation.EditTopic as EditTopic exposing (EditTopic)
import App.Store as Store
import App.Store.Data as StoreData
import App.Store.Mode as StoreMode
import App.Store.Msg as StoreMsg
import App.Topic exposing (Topic)
import App.Topic.Store as TopicStore
import App.TopicCard as TopicCard exposing (TopicCard)
import App.TopicFilter as TopicFilter exposing (TopicFilter)
import Browser.Navigation as Nav
import Data.Tree as Tree exposing (Tree)
import Http
import I18n.Lang exposing (Lang)
import I18n.Port
import I18n.Translator
    exposing
        ( TextsNeedToBeTranslated
        , TranslateResult
        )
import Task
import Time
import Url
import View.I18n.Default
import View.Page as Page
import View.Route
import Widget.Util.Basic
    exposing
        ( appendToUniqueList
        , removeFromList
        , trim
        )


type alias State =
    { title : String
    , description : String

    -- 国际化
    , lang : Lang
    , webCtxRootPath : String
    , textsWithoutI18n : List TextsNeedToBeTranslated
    , timeZone : Time.Zone
    , themeDark : Bool

    -- 路由
    , navKey : Nav.Key
    , navUrl : Url.Url
    , navs : List (Cmd Msg)

    -- 远程请求错误信息
    , storeError : Maybe TranslateResult
    , currentPage : Page.Type

    -- 业务数据
    , store :
        { topic : TopicStore.Store
        }
    , topicCards : StoredTopicCards

    -- 操作数据
    , topicFilter : TopicFilter
    , trashedTopicStats : TopicStats
    , newTopic : Maybe EditTopic
    , editTopic : Maybe EditTopic
    , topicTagEditInputId : String
    , topicsCleaner : Maybe TopicsCleaner
    }


type alias Config =
    { title : String
    , description : String
    , lang : String
    , webCtxRootPath : String
    , navKey : Nav.Key
    , navUrl : Url.Url
    , storeMode : StoreMode.Mode
    }


type alias StoredTopicCards =
    StoreData.Status (Tree TopicCard)


type alias TopicStats =
    { size : Int
    }


init : Config -> ( State, Cmd Msg )
init config =
    let
        ( state, cmd ) =
            { title = config.title
            , description = config.description

            --
            , lang =
                I18n.Lang.fromStringWithDefault
                    View.I18n.Default.lang
                    config.lang
            , webCtxRootPath = config.webCtxRootPath
            , textsWithoutI18n = []
            , timeZone = Time.utc
            , themeDark = True

            --
            , navKey = config.navKey
            , navUrl = config.navUrl
            , navs = []

            --
            , storeError = Nothing
            , currentPage = Page.Loading

            --
            , store =
                { topic =
                    TopicStore.store config.storeMode
                }
            , topicCards = StoreData.LoadWaiting

            --
            , topicFilter = TopicFilter.all
            , trashedTopicStats = { size = 0 }
            , newTopic = Nothing
            , editTopic = Nothing
            , topicTagEditInputId = "topic-tag-edit-input"
            , topicsCleaner = Nothing
            }
                |> routeUpdateHelper config.navUrl
    in
    ( state
    , Cmd.batch
        [ cmd
        , Task.perform Msg.AdjustTimeZone Time.here
        ]
    )


sub : State -> Sub Msg
sub state =
    Sub.batch
        [ I18n.Port.sub Msg.I18nPortMsg
        ]


update : Msg -> Int -> State -> ( State, Cmd Msg, Maybe ( Int, Bool ) )
update msg nextMsgId ({ topicFilter } as state) =
    case msg of
        Msg.StoreMsg storeMsg ->
            storeUpdateHelper storeMsg state

        Msg.UrlChanged url ->
            withOutNextMsg <|
                routeUpdateHelper url state

        Msg.I18nPortMsg i18nPortMsg ->
            withOutNextMsg <|
                i18nUpdateHelper i18nPortMsg state

        Msg.SwitchToDarkTheme dark ->
            withOutNextMsg <|
                ( { state | themeDark = dark }
                , Cmd.none
                )

        Msg.AdjustTimeZone zone ->
            withOutNextMsg <|
                ( { state | timeZone = zone }
                , Cmd.none
                )

        Msg.NavBackTo level ->
            withOutNextMsg <|
                navBackToHelper level state

        Msg.FilterTopicKeywordInputing keyword ->
            withOutNextMsg <|
                ( { state
                    | topicFilter =
                        { topicFilter
                            | keyword = Just keyword
                        }
                  }
                , Cmd.none
                )

        Msg.FilterTopicByKeyword ->
            withOutNextMsg <|
                ( state
                , View.Route.filterTopics
                    topicFilter
                    state.navKey
                )

        Msg.FilterTopicTagSelected tag ->
            withOutNextMsg <|
                ( state
                , View.Route.filterTopics
                    { topicFilter
                        | tags =
                            topicFilter.tags
                                |> appendToUniqueList tag
                    }
                    state.navKey
                )

        Msg.FilterTopicTagDeleted tag ->
            withOutNextMsg <|
                ( state
                , View.Route.filterTopics
                    { topicFilter
                        | tags =
                            topicFilter.tags
                                |> removeFromList tag
                    }
                    state.navKey
                )

        Msg.ShowTashedTopics ->
            let
                filter =
                    TopicFilter.all
            in
            withOutNextMsg <|
                ( state
                , View.Route.filterTopics
                    { filter
                        | trashed = True
                    }
                    state.navKey
                )

        Msg.TopicCardMsg topicId topicCardMsg ->
            withOutNextMsg <|
                topicCardUpdateHelper topicId topicCardMsg state

        Msg.RemoveTopicCard topicId ->
            withOutNextMsg <|
                ( state |> removeTopicCard topicId
                , Cmd.none
                )

        Msg.NewTopicPending ->
            withOutNextMsg <|
                ( { state | newTopic = Just EditTopic.init }
                , Cmd.none
                )

        Msg.NewTopicMsg newTopicMsg ->
            withOutNextMsg <|
                newTopicUpdateHelper newTopicMsg state

        Msg.NewTopicSaving ->
            withOutNextMsg <|
                newTopicSavingHelper nextMsgId state

        Msg.NewTopicCleaned ->
            withOutNextMsg <|
                ( { state
                    | newTopic = Nothing
                  }
                , Cmd.none
                )

        Msg.EditTopicPending topicId ->
            withOutNextMsg <|
                ( state |> initEditTopic topicId
                , Cmd.none
                )

        Msg.EditTopicMsg editTopicMsg ->
            withOutNextMsg <|
                editTopicUpdateHelper editTopicMsg state

        Msg.EditTopicSaving ->
            withOutNextMsg <|
                editTopicSavingHelper nextMsgId state

        Msg.EditTopicCleaned ->
            withOutNextMsg <|
                ( { state | editTopic = Nothing }
                , Cmd.none
                )

        Msg.CleanTopicsMsg cleanTopicsMsg ->
            withOutNextMsg <|
                cleanTopicsUpdateHelper nextMsgId cleanTopicsMsg state

        _ ->
            withOutNextMsg <|
                ( state, Cmd.none )


withOutNextMsg : ( State, Cmd Msg ) -> ( State, Cmd Msg, Maybe ( Int, Bool ) )
withOutNextMsg ( state, msg ) =
    ( state, msg, Nothing )


isEmptyTopicCards : State -> Bool
isEmptyTopicCards { topicCards } =
    topicCards
        |> StoreData.map Tree.isEmpty
        |> Maybe.withDefault True


getTopic : String -> State -> Maybe Topic
getTopic topicId { topicCards } =
    topicCards
        |> StoreData.andThen
            (Tree.get topicId)
        |> Maybe.map .topic


updateTopicCard : String -> TopicCard.Msg -> State -> State
updateTopicCard topicId topicCardMsg state =
    state
        |> updateTopicCardHelper topicId
            (TopicCard.update
                topicCardMsg
            )


removeTopicCard : String -> State -> State
removeTopicCard topicId ({ topicCards } as state) =
    { state
        | topicCards =
            topicCards
                |> StoreData.update
                    (Tree.removeById topicId)
    }


updateNewTopic :
    (EditTopic -> EditTopic)
    -> State
    -> State
updateNewTopic updater ({ newTopic } as state) =
    { state | newTopic = newTopic |> Maybe.map updater }


prepareSavingNewTopic : State -> ( Maybe EditTopic, Maybe Topic )
prepareSavingNewTopic { lang, newTopic } =
    newTopic
        |> Maybe.map
            (\newTopic_ ->
                case trim newTopic_.content of
                    Nothing ->
                        ( Just
                            (newTopic_
                                |> EditTopic.error
                                    ([ "主题内容是空白的，请先输入点什么" ]
                                        |> I18n.translate lang
                                    )
                            )
                        , Nothing
                        )

                    _ ->
                        ( Just { newTopic_ | updating = True }
                        , Just (EditTopic.to newTopic_)
                        )
            )
        |> Maybe.withDefault ( newTopic, Nothing )


updateSavedNewTopic :
    Result Http.Error Topic
    -> State
    -> State
updateSavedNewTopic result ({ lang } as state) =
    case result of
        Ok topic ->
            state
                |> updateNewTopic
                    EditTopic.clean
                |> updateNewTopic
                    (EditTopic.info
                        ([ "新增主题已保存成功" ]
                            |> I18n.translate lang
                        )
                    )
                |> addTopicHelper topic

        Err error ->
            state
                |> updateNewTopic
                    (EditTopic.error
                        (Store.parseError lang error)
                    )
                |> updateNewTopic (\t -> { t | updating = False })


initEditTopic :
    String
    -> State
    -> State
initEditTopic topicId state =
    { state
        | editTopic =
            state
                |> getTopic topicId
                |> Maybe.map EditTopic.from
    }


updateEditTopic :
    (EditTopic -> EditTopic)
    -> State
    -> State
updateEditTopic updater ({ editTopic } as state) =
    { state | editTopic = editTopic |> Maybe.map updater }


prepareSavingEditTopic : State -> ( Maybe EditTopic, Maybe Topic )
prepareSavingEditTopic ({ lang, editTopic } as state) =
    editTopic
        |> Maybe.map
            (\editTopic_ ->
                case trim editTopic_.content of
                    Nothing ->
                        ( Just
                            (editTopic_
                                |> EditTopic.error
                                    ([ "主题内容是空白的，请先输入点什么" ]
                                        |> I18n.translate lang
                                    )
                            )
                        , Nothing
                        )

                    _ ->
                        ( Just { editTopic_ | updating = True }
                        , state
                            |> getTopic editTopic_.id
                            |> Maybe.map
                                (EditTopic.patch editTopic_)
                        )
            )
        |> Maybe.withDefault ( editTopic, Nothing )


updateSavedEditTopic :
    Result Http.Error Topic
    -> State
    -> State
updateSavedEditTopic result ({ lang } as state) =
    case result of
        Ok topic ->
            state
                |> updateEditTopic
                    (EditTopic.info
                        ([ "当前主题已更新成功" ]
                            |> I18n.translate lang
                        )
                    )
                |> updateEditTopic (\t -> { t | updating = False })
                |> addTopicHelper topic

        Err error ->
            state
                |> updateEditTopic
                    (EditTopic.error
                        (Store.parseError lang error)
                    )
                |> updateEditTopic (\t -> { t | updating = False })


updateTopicsCleaner :
    (TopicsCleaner -> TopicsCleaner)
    -> State
    -> State
updateTopicsCleaner updater ({ topicsCleaner } as state) =
    { state | topicsCleaner = topicsCleaner |> Maybe.map updater }



-- --------------------------------------------------------------------


addTopicHelper :
    Topic
    -> State
    -> State
addTopicHelper topic ({ topicCards } as state) =
    let
        addTopicToStore topic_ store =
            store
                |> Tree.add
                    (store
                        |> Tree.get topic_.id
                        |> Maybe.map
                            (\topicCard ->
                                { topicCard | topic = topic_ }
                            )
                        |> Maybe.withDefault (TopicCard.create topic_)
                    )
    in
    { state
        | topicCards =
            topicCards
                |> StoreData.update
                    (addTopicToStore topic)
    }


updateTopicCardHelper :
    String
    -> (TopicCard -> TopicCard)
    -> State
    -> State
updateTopicCardHelper topicId updater ({ topicCards } as state) =
    topicCards
        |> StoreData.andThen
            (Tree.get topicId)
        |> Maybe.map
            (\topicCard ->
                { state
                    | topicCards =
                        topicCards
                            |> StoreData.update
                                (Tree.add
                                    (updater topicCard)
                                )
                }
            )
        |> Maybe.withDefault state


createTopicCardsHelper : List Topic -> Tree TopicCard
createTopicCardsHelper topics =
    let
        posixToMillis posixMaybe =
            posixMaybe
                |> Maybe.map Time.posixToMillis
                |> Maybe.withDefault 0
    in
    Tree.create
        { idGetter = \{ topic } -> topic.id
        , parentGetter = \_ -> Nothing
        , sorter =
            Just
                (\a b ->
                    compare
                        (posixToMillis b.topic.updatedAt)
                        (posixToMillis a.topic.updatedAt)
                )
        }
        (topics |> List.map TopicCard.create)


{-| 远程请求更新
-}
storeUpdateHelper :
    StoreMsg.Msg
    -> State
    -> ( State, Cmd Msg, Maybe ( Int, Bool ) )
storeUpdateHelper msg ({ lang, store, topicFilter } as state) =
    case msg of
        StoreMsg.QueryMyTopics result ->
            withOutNextMsg <|
                ( { state
                    | topicCards =
                        result
                            |> StoreData.from
                                lang
                                createTopicCardsHelper
                  }
                , Cmd.none
                )

        StoreMsg.CountMyTopics trashed result ->
            withOutNextMsg <|
                ( case result of
                    Ok stats ->
                        if trashed then
                            { state
                                | trashedTopicStats = stats
                            }

                        else
                            state

                    Err _ ->
                        state
                , Cmd.none
                )

        StoreMsg.SaveMyNewTopic nextMsgId result ->
            ( state
                |> updateSavedNewTopic result
            , Cmd.none
            , Just
                ( nextMsgId
                , case result of
                    Ok _ ->
                        True

                    Err _ ->
                        False
                )
            )

        StoreMsg.SaveMyEditTopic nextMsgId result ->
            ( state
                |> updateSavedEditTopic result
            , Cmd.none
            , Just
                ( nextMsgId
                , case result of
                    Ok _ ->
                        True

                    Err _ ->
                        False
                )
            )

        StoreMsg.TrashMyTopic topicId result ->
            withOutNextMsg <|
                ( state
                    |> updateTopicCard topicId
                        (case result of
                            Ok _ ->
                                TopicCard.Trash Operation.Done

                            Err e ->
                                TopicCard.Trash
                                    (Operation.Error
                                        (Store.parseError lang e)
                                    )
                        )
                , Cmd.batch
                    [ countTrashedTopicsCmd state
                    ]
                )

        StoreMsg.DeleteMyTopic topicId result ->
            withOutNextMsg <|
                ( state
                    |> updateTopicCard topicId
                        (case result of
                            Ok _ ->
                                TopicCard.Delete Operation.Done

                            Err e ->
                                TopicCard.Delete
                                    (Operation.Error
                                        (Store.parseError lang e)
                                    )
                        )
                , Cmd.none
                )

        StoreMsg.RestoreMyTrashedTopic topicId result ->
            withOutNextMsg <|
                ( state
                    |> updateTopicCard topicId
                        (case result of
                            Ok _ ->
                                TopicCard.Restore Operation.Done

                            Err e ->
                                TopicCard.Restore
                                    (Operation.Error
                                        (Store.parseError lang e)
                                    )
                        )
                , Cmd.none
                )

        StoreMsg.DeleteMyTopics nextMsgId result ->
            case result of
                Ok _ ->
                    ( state
                    , Msg.fromStoreCmd
                        (store.topic.query topicFilter)
                    , Just
                        ( nextMsgId, True )
                    )

                Err e ->
                    let
                        ( s, c ) =
                            state
                                |> cleanTopicsUpdateHelper nextMsgId
                                    (CleanTopics.CleanError
                                        (Store.parseError lang e)
                                    )
                    in
                    ( s
                    , c
                    , Just
                        ( nextMsgId, False )
                    )

        _ ->
            withOutNextMsg <|
                ( state, Cmd.none )


routeUpdateHelper : Url.Url -> State -> ( State, Cmd Msg )
routeUpdateHelper navUrl state =
    let
        ( page, newState, cmd ) =
            case View.Route.route navUrl of
                View.Route.Home ->
                    let
                        ( s, c ) =
                            state
                                |> doStoreQueryMyTopics
                                    TopicFilter.all
                    in
                    ( Page.Home False, s, c )

                View.Route.TopicsFilter filter ->
                    let
                        ( s, c ) =
                            state
                                |> doStoreQueryMyTopics
                                    filter
                    in
                    ( Page.Home False, s, c )

                View.Route.TrashedTopicsFilter filter ->
                    let
                        ( s, c ) =
                            state
                                |> doStoreQueryMyTopics
                                    filter
                    in
                    ( Page.Home True, s, c )

                View.Route.Forbidden ->
                    ( Page.Forbidden, state, Cmd.none )

                View.Route.NotFound ->
                    ( Page.NotFound, state, Cmd.none )
    in
    ( { newState
        | currentPage = page
        , navUrl = navUrl
      }
    , cmd
    )


i18nUpdateHelper : I18n.Port.Msg -> State -> ( State, Cmd Msg )
i18nUpdateHelper msg state =
    case I18n.Port.update msg of
        ( r, m ) ->
            ( { state
                | textsWithoutI18n = r.results
              }
            , m
            )


navBackToHelper : Int -> State -> ( State, Cmd Msg )
navBackToHelper level ({ navs } as state) =
    let
        leftNavAmount =
            List.length navs - level

        leftNavs =
            navs
                |> List.take leftNavAmount

        newNav =
            navs
                |> List.drop leftNavAmount
                |> List.take 1
    in
    ( { state | navs = leftNavs }
    , Cmd.batch newNav
    )


topicCardUpdateHelper :
    String
    -> TopicCard.Msg
    -> State
    -> ( State, Cmd Msg )
topicCardUpdateHelper topicId msg ({ store } as state) =
    ( state
        |> updateTopicCard topicId msg
    , case msg of
        TopicCard.Trash op ->
            case op of
                Operation.Doing ->
                    Msg.fromStoreCmd
                        (store.topic.trash topicId)

                _ ->
                    Cmd.none

        TopicCard.Delete op ->
            case op of
                Operation.Doing ->
                    Msg.fromStoreCmd
                        (store.topic.delete topicId)

                _ ->
                    Cmd.none

        TopicCard.Restore op ->
            case op of
                Operation.Doing ->
                    Msg.fromStoreCmd
                        (store.topic.trashRestore topicId)

                _ ->
                    Cmd.none

        _ ->
            Cmd.none
    )


newTopicUpdateHelper :
    EditTopic.Msg
    -> State
    -> ( State, Cmd Msg )
newTopicUpdateHelper msg state =
    ( state
        |> updateNewTopic
            (EditTopic.update msg)
    , case msg of
        EditTopic.TagDeleted _ ->
            Msg.focusOn state.topicTagEditInputId

        _ ->
            Cmd.none
    )


newTopicSavingHelper :
    Int
    -> State
    -> ( State, Cmd Msg )
newTopicSavingHelper nextMsgId ({ store } as state) =
    let
        ( newTopic, topic ) =
            prepareSavingNewTopic state
    in
    ( state
        |> (\s -> { s | newTopic = newTopic })
    , topic
        |> Maybe.map
            (\t ->
                Msg.fromStoreCmd
                    (store.topic.add nextMsgId t)
            )
        |> Maybe.withDefault
            Cmd.none
    )


editTopicSavingHelper :
    Int
    -> State
    -> ( State, Cmd Msg )
editTopicSavingHelper nextMsgId ({ store } as state) =
    let
        ( editTopic, topic ) =
            prepareSavingEditTopic state
    in
    ( state
        |> (\s -> { s | editTopic = editTopic })
    , topic
        |> Maybe.map
            (\t ->
                Msg.fromStoreCmd
                    (store.topic.update nextMsgId t)
            )
        |> Maybe.withDefault
            Cmd.none
    )


editTopicUpdateHelper :
    EditTopic.Msg
    -> State
    -> ( State, Cmd Msg )
editTopicUpdateHelper msg state =
    ( state
        |> updateEditTopic
            (EditTopic.update msg)
    , case msg of
        EditTopic.TagDeleted _ ->
            Msg.focusOn state.topicTagEditInputId

        _ ->
            Cmd.none
    )


cleanTopicsUpdateHelper :
    Int
    -> CleanTopics.Msg
    -> State
    -> ( State, Cmd Msg )
cleanTopicsUpdateHelper nextMsgId msg ({ store, topicFilter } as state) =
    case msg of
        CleanTopics.CleanPending ->
            ( { state
                | topicsCleaner = Just CleanTopics.create
              }
            , Cmd.none
            )

        CleanTopics.CleanDoing ->
            ( state
                |> updateTopicsCleaner
                    (CleanTopics.update msg)
            , Msg.fromStoreCmd
                (store.topic.deleteFiltered nextMsgId topicFilter)
            )

        CleanTopics.CleanCancel ->
            ( { state | topicsCleaner = Nothing }
            , Cmd.none
            )

        _ ->
            ( state
                |> updateTopicsCleaner
                    (CleanTopics.update msg)
            , Cmd.none
            )


doStoreQueryMyTopics :
    TopicFilter
    -> State
    -> ( State, Cmd Msg )
doStoreQueryMyTopics ({ trashed } as topicFilter) ({ store } as state) =
    ( { state
        | topicCards = StoreData.Loading
        , topicFilter = topicFilter
        , navs =
            if not trashed then
                []

            else if List.isEmpty state.navs then
                [ View.Route.filterTopics
                    state.topicFilter
                    state.navKey
                ]

            else
                state.navs
      }
    , Cmd.batch
        [ Msg.fromStoreCmd
            (store.topic.query topicFilter)
        , countTrashedTopicsCmd state
        ]
    )


countTrashedTopicsCmd : State -> Cmd Msg
countTrashedTopicsCmd { store } =
    let
        filter =
            TopicFilter.all
    in
    Msg.fromStoreCmd
        (store.topic.count { filter | trashed = True })
