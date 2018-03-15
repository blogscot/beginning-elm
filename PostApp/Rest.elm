module Rest exposing (createPostCommand, deletePostCommand, fetchPostsCommand, updatePostCommand)

import Http
import Json.Decode exposing (Decoder, int, list, string)
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as Encode
import RemoteData
import Types exposing (..)


postsUrl : String
postsUrl =
    "http://localhost:3000/posts/"


authorDecoder : Decoder Author
authorDecoder =
    decode Author
        |> required "name" string
        |> required "url" string


postDecoder : Decoder Post
postDecoder =
    decode Post
        |> required "id" int
        |> required "title" string
        |> required "author" authorDecoder


fetchPostsCommand : Cmd Msg
fetchPostsCommand =
    list postDecoder
        |> Http.get postsUrl
        |> RemoteData.sendRequest
        |> Cmd.map PostsReceived


updatePostCommand : Post -> Cmd Msg
updatePostCommand post =
    updatePostRequest post
        |> Http.send PostUpdated


updatePostRequest : Post -> Http.Request Post
updatePostRequest post =
    Http.request
        { method = "PATCH"
        , headers = []
        , url = postsUrl ++ toString post.id
        , body = Http.jsonBody (postEncoder post)
        , expect = Http.expectJson postDecoder
        , timeout = Nothing
        , withCredentials = False
        }


deletePostCommand : Post -> Cmd Msg
deletePostCommand post =
    deletePostRequest post
        |> Http.send PostDeleted


deletePostRequest : Post -> Http.Request String
deletePostRequest post =
    Http.request
        { method = "DELETE"
        , headers = []
        , url = postsUrl ++ toString post.id
        , body = Http.emptyBody
        , expect = Http.expectString
        , timeout = Nothing
        , withCredentials = False
        }


postEncoder : Post -> Encode.Value
postEncoder post =
    Encode.object
        [ ( "id", Encode.int post.id )
        , ( "title", Encode.string post.title )
        , ( "author", authorEncoder post.author )
        ]


authorEncoder : Author -> Encode.Value
authorEncoder author =
    Encode.object
        [ ( "name", Encode.string author.name )
        , ( "url", Encode.string author.url )
        ]


createPostCommand : Post -> Cmd Msg
createPostCommand post =
    createPostRequest post
        |> Http.send PostCreated


createPostRequest : Post -> Http.Request Post
createPostRequest post =
    Http.request
        { method = "POST"
        , headers = []
        , url = postsUrl
        , body = Http.jsonBody (newPostEncoder post)
        , expect = Http.expectJson postDecoder
        , timeout = Nothing
        , withCredentials = False
        }


newPostEncoder : Post -> Encode.Value
newPostEncoder post =
    Encode.object
        [ ( "title", Encode.string post.title )
        , ( "author", authorEncoder post.author )
        ]
