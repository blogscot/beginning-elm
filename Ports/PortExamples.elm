port module PortExamples exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (Value, decodeValue, string)
import State exposing (init)
import Types exposing (..)


port sendData : ComplexData -> Cmd msg


port receiveData : (Value -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveData ReceivedDataFromJS


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick SendDataToJS ]
            [ text "Send Data to JavaScript" ]
        , viewDataFromJSOrError model
        ]


viewDataFromJSOrError : Model -> Html Msg
viewDataFromJSOrError model =
    case model.errorMessage of
        Just message ->
            viewError message

        Nothing ->
            viewDataFromJS model.dataFromJS


viewError : String -> Html Msg
viewError errorMessage =
    let
        errorHeading =
            "Couldn't receive data from JavaScript"
    in
    div []
        [ h3 [] [ text errorHeading ]
        , text ("Error: " ++ errorMessage)
        ]


viewDataFromJS : String -> Html msg
viewDataFromJS data =
    div []
        [ h3 [] [ text "Received the following data from JavaScript" ]
        , text data
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendDataToJS ->
            ( model, sendData model.dataToJS )

        ReceivedDataFromJS value ->
            case decodeValue string value of
                Ok data ->
                    ( { model | dataFromJS = data }, Cmd.none )

                Err error ->
                    ( { model | errorMessage = Just error }, Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
