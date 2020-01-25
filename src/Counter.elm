module Counter exposing (Model, Msg, init, update, view)

import Element exposing (padding, row, spacing, text)
import Element.Input exposing (button)


type alias Model =
    { counter : Int }


type Msg
    = Plus
    | Minus


init : Model
init =
    Model 0


update : Msg -> Model -> Model
update msg model =
    case msg of
        Plus ->
            { model | counter = model.counter + 1 }

        Minus ->
            if model.counter == 0 then
                model

            else
                { model | counter = model.counter - 1 }


view : String -> Model -> Element.Element Msg
view title model =
    row
        [ padding 3
        , spacing 20
        ]
        [ text title
        , button [] { onPress = Just Minus, label = text "-" }
        , text <| String.fromInt model.counter
        , button [] { onPress = Just Plus, label = text "+" }
        ]
