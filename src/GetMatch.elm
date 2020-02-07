module GetMatch exposing (getMatch, maybeIntToInt, stationIndex, unwrapToString)

import List.Extra exposing (getAt)
import Maybe exposing (andThen)
import Maybe.Extra exposing (unwrap)


type alias Alliance =
    { one : Int
    , two : Int
    , three : Int
    }


type alias Match =
    { blue : Alliance
    , red : Alliance
    }


matches : List Match
matches =
    [ { blue = { one = 1690, two = 1574, three = 3339 }, red = { one = 254, two = 2056, three = 1323 } }
    , { blue = { one = 118, two = 1577, three = 1024 }, red = { one = 2056, two = 1690, three = 254 } }
    , { blue = { one = 1574, two = 3339, three = 1577 }, red = { one = 1323, two = 1024, three = 118 } }
    , { blue = { one = 3339, two = 1574, three = 1577 }, red = { one = 1024, two = 118, three = 2056 } }
    ]


checkMatch : Maybe Int -> Maybe Match
checkMatch match =
    andThen (\n -> getAt (n - 1) matches) match


unwrapToString : Maybe Int -> String
unwrapToString maybeInt =
    unwrap "" String.fromInt maybeInt


maybeIntToInt : Maybe Int -> Int
maybeIntToInt mi =
    case mi of
        Nothing ->
            0

        Just n ->
            n


getMatch : Maybe Int -> String -> String
getMatch match station =
    stationIndex match <| station


stationIndex : Maybe Int -> String -> String
stationIndex match station =
    case checkMatch match of
        Nothing ->
            "Not a match"

        Just matchData ->
            if station == "Blue 1" then
                String.fromInt matchData.blue.one

            else if station == "Blue 2" then
                String.fromInt matchData.blue.two

            else if station == "Blue 3" then
                String.fromInt matchData.blue.three

            else if station == "Red 1" then
                String.fromInt matchData.red.one

            else if station == "Red 2" then
                String.fromInt matchData.red.two

            else if station == "Red 3" then
                String.fromInt matchData.red.three

            else
                "Not a station"
