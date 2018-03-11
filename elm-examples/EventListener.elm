module EventListener exposing (..)

import Char exposing (fromCode)
import Html exposing (..)
import Keyboard exposing (KeyCode)


type alias Model =
    { code : KeyCode
    , character : Char
    }


type Msg
    = KeyDowns KeyCode
    | Clear


initialModel : { character : Char, code : KeyCode }
initialModel =
    { code = 0
    , character = ' '
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyDowns code ->
            ( { model | code = code, character = fromCode code }, Cmd.none )

        Clear ->
            ( initialModel, Cmd.none )


view : Model -> Html Msg
view model =
    div [] [ text <| "Key Info: " ++ toString model ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.downs KeyDowns
        , Keyboard.ups (always Clear)
        ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
