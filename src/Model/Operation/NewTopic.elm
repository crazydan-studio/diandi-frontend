module Model.Operation.NewTopic exposing
    ( Msg(..)
    , NewTopic
    , init
    , update
    )

import Element.Input exposing (Selection)


type alias NewTopic =
    { content : String
    , selection : Maybe Selection
    , focused : Bool
    , error : Maybe String
    }


type Msg
    = InputFocusIn
    | InputFocusOut
    | InputFocusBlur Selection
    | InputContentChanged String


init : NewTopic
init =
    { content = ""
    , selection = Nothing
    , focused = False
    , error = Nothing
    }


update : Msg -> NewTopic -> NewTopic
update msg newTopic =
    case msg of
        InputFocusIn ->
            { newTopic | focused = True }

        InputFocusOut ->
            { newTopic | focused = False }

        InputFocusBlur selection ->
            { newTopic | selection = Just selection }

        InputContentChanged content ->
            { newTopic
                | content = content
                , error = Nothing
            }
