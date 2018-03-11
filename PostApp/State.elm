module State exposing (..)

import RemoteData exposing (WebData)
import Rest exposing (fetchPostsCommand)
import Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( { posts = RemoteData.Loading }, fetchPostsCommand )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchPosts ->
            ( { model | posts = RemoteData.Loading }, fetchPostsCommand )

        PostsReceived response ->
            ( { model | posts = response }, Cmd.none )
