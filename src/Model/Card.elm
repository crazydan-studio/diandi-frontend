module Model.Card exposing (Card)

{-| 点滴卡片

任务、知识等内容的载体

-}


type alias Card =
    { id : String
    , content : String
    , tags : List String
    , color : String

    -- 上级卡片id
    , superior : String
    }
