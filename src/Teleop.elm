module Teleop exposing (Model, Msg, createButton, init, subscriptions, update, view, yophyTophy)

import Colors exposing (black, blue, purple, sky, white)
import Counter
import Element exposing (centerX, centerY, column, el, padding, row, spacing, text)
import Element.Background as Background
import Element.Border as Border exposing (rounded, widthXY)
import Element.Font as Font exposing (center)
import Element.Input exposing (button)


type Msg
    = LowLevel Counter.Msg
    | HighLevel Counter.Msg
    | Missed Counter.Msg
    | ColorRoulette
    | SpunRoulette


type alias Model =
    { lowlevel : Counter.Model
    , highlevel : Counter.Model
    , missed : Counter.Model
    , colorRoulette : Bool
    , spunRoulette : Bool
    }


init : Model
init =
    Model (Counter.Model 0) (Counter.Model 0) (Counter.Model 0) False False


createButton : Msg -> String -> Element.Element Msg
createButton msg name =
    button
        [ Font.color white
        , Font.size 25
        , Font.glow blue 5
        , Border.rounded 10
        , Font.family
            [ Font.external
                { name = "Open Sans"
                , url = "https://fonts.googleapis.com/css?family=Open+Sans:700i&display=swap"
                }
            ]
        , Background.color purple
        , center
        , centerX
        , centerY
        ]
        { onPress = Just msg, label = text name }


update : Msg -> Model -> Model
update msg model =
    let
        counterUpdate : Counter.Msg -> Counter.Model -> Counter.Model
        counterUpdate =
            Counter.update
    in
    case msg of
        LowLevel count ->
            { model | lowlevel = counterUpdate count model.lowlevel }

        HighLevel count ->
            { model | highlevel = counterUpdate count model.highlevel }

        ColorRoulette ->
            { model | colorRoulette = not model.colorRoulette }

        SpunRoulette ->
            { model | spunRoulette = not model.spunRoulette }

        Missed count ->
            { model | missed = counterUpdate count model.missed }


view : Model -> Element.Element Msg
view model =
    column
        [ Background.color sky
        , Border.color black
        , padding 50
        , spacing 20
        , widthXY 5 5
        , rounded 10
        , centerX
        , centerY
        ]
        [ row yophyTophy
            [ column yophyTophy
                [ el yophyTophy
                    (text "spun to\ncorrect color?")
                , createButton ColorRoulette <|
                    if model.colorRoulette then
                        "Yes"

                    else
                        "No"
                ]
            , column yophyTophy
                [ el yophyTophy
                    (text "spun cycles 3-5?")
                , createButton SpunRoulette <|
                    if model.spunRoulette then
                        "Yes"

                    else
                        "No"
                ]
            ]
        , Element.map LowLevel <| Counter.view "low Level:" model.lowlevel
        , Element.map HighLevel <| Counter.view "high Level:" model.highlevel
        , Element.map Missed <| Counter.view "missed:" model.missed
        ]


subscriptions : Sub Msg
subscriptions =
    Sub.none


yophyTophy : List (Element.Attribute Msg)
yophyTophy =
    [ padding 10
    , spacing 5
    , centerX
    , centerY
    ]
