port module PortExamples exposing (..)

import Html exposing (..)
import Html.Events exposing (..)


type alias Model =
    String


port sendData : String -> Cmd msg


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick SendDataToJS ]
            [ text "Send Data to JavaScript" ]
        ]


type Msg
    = SendDataToJS


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendDataToJS ->
            ( model, sendData "Hello JavaScript!" )


init : ( Model, Cmd Msg )
init =
    ( "", Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
