module Util exposing (hash)

import Hex
import Murmur3


hash : String -> String
hash str =
    str
        |> Murmur3.hashString 0
        |> Hex.toString
