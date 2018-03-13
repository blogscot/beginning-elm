module State exposing (..)

import Navigation exposing (Location)
import RemoteData exposing (WebData)
import Rest exposing (fetchPostsCommand)
import Routing exposing (extractRoute)
import Types exposing (..)


initialModel : Route -> Model
initialModel route =
    { posts = RemoteData.Loading, currentRoute = route }


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.extractRoute location
    in
    ( initialModel currentRoute, fetchPostsCommand )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchPosts ->
            ( { model | posts = RemoteData.Loading }, fetchPostsCommand )

        PostsReceived response ->
            ( { model | posts = response }, Cmd.none )

        OnLocationChange location ->
            let
                newRoute =
                    Routing.extractRoute location
            in
            ( { model | currentRoute = newRoute }, Cmd.none )
