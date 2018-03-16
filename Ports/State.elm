module State exposing (init)

import Types exposing (..)


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    { dataFromJS = ""
    , dataToJS = complexData
    , errorMessage = Nothing
    }


complexData : ComplexData
complexData =
    let
        post1 =
            Author "typicode" "https://github.com/typicode"
                |> Post 1 "json-server"

        post2 =
            Author "indexzero" "https://github.com/indexzero"
                |> Post 2 "http-server"
    in
    { posts = [ post1, post2 ]
    , comments = [ Comment 1 "some comment" 1 ]
    , profile = { name = "typicode" }
    }
