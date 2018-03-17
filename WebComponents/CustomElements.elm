module CustomElements exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (Decoder, float)
import Json.Decode.Pipeline exposing (decode, requiredAt)


type Msg
    = UpdateCenter Coordinates


type alias Model =
    { center : Coordinates
    , markers : List Marker
    }


type alias Coordinates =
    { latitude : Float
    , longitude : Float
    }


type alias Marker =
    { coordinates : Coordinates
    , title : String
    , imageUrl : String
    }


googleMap : List (Attribute a) -> List (Html a) -> Html a
googleMap =
    Html.node "google-map"


googleMapMarker : List (Attribute a) -> List (Html a) -> Html a
googleMapMarker =
    Html.node "google-map-marker"


onGoogleMapDrag : Attribute Msg
onGoogleMapDrag =
    coordinatesDecoder
        |> Json.Decode.map UpdateCenter
        |> on "google-map-drag"


coordinatesDecoder : Decoder Coordinates
coordinatesDecoder =
    decode Coordinates
        |> requiredAt [ "target", "latitude" ] float
        |> requiredAt [ "target", "longitude" ] float


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text "Highest Mountains on Earth" ]
        , googleMap
            [ attribute "latitude" (toString model.center.latitude)
            , attribute "longitude" (toString model.center.longitude)
            , attribute "drag-events" "true"
            , attribute "zoom" "5"
            , onGoogleMapDrag
            ]
            (List.map viewMarker model.markers)
        , viewCoordinates model.center
        ]


viewMarker : Marker -> Html Msg
viewMarker marker =
    googleMapMarker
        [ attribute "latitude" (toString marker.coordinates.latitude)
        , attribute "longitude" (toString marker.coordinates.longitude)
        , attribute "title" marker.title
        ]
        [ img [ src marker.imageUrl, width 140, height 105 ] []
        , br [] []
        , text marker.title
        ]


viewCoordinates : Coordinates -> Html Msg
viewCoordinates mapCenter =
    div []
        [ h3 []
            [ text "The above map is centered on the following coordinates:" ]
        , text ("Latitude: " ++ toString mapCenter.latitude)
        , br [] []
        , text ("Longitude: " ++ toString mapCenter.longitude)
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateCenter coordinates ->
            ( { model | center = coordinates }, Cmd.none )


initialModel : Model
initialModel =
    let
        center =
            Coordinates 32.545349 82.689855

        markers =
            [ Marker (Coordinates 27.9878 86.925) "Everest" "https://goo.gl/Di3zLj"
            , Marker (Coordinates 35.88 76.5151) "K2" "https://goo.gl/fYjfa4"
            , Marker (Coordinates 27.7025 88.1475) "Kanchenjunga" "https://goo.gl/jAokum"
            ]
    in
    { center = center
    , markers = markers
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
