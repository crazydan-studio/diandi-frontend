module App.TopicFilter exposing
    ( TopicFilter
    , all
    )


type alias TopicFilter =
    { keyword : Maybe String
    , tags : List String
    }


all : TopicFilter
all =
    { keyword = Nothing
    , tags = []
    }
