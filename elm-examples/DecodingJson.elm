module DecodingJson exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick)
import Http
import Json.Decode exposing (Decoder, decodeString, field, int, list, map3, string)
import Json.Decode.Pipeline exposing (decode, optional, optionalAt, required, requiredAt)


type alias Author =
    { name : String
    , url : String
    }


type alias Post =
    { id : Int
    , title : String
    , author : Author
    }


type alias Model =
    { posts : List Post
    , errorMessage : Maybe String
    }


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick SendHttpRequest ]
            [ text "Get data from server" ]
        , viewPostsOrError model
        ]


viewPostsOrError : Model -> Html Msg
viewPostsOrError model =
    case model.errorMessage of
        Just message ->
            viewError message

        Nothing ->
            viewPosts model.posts


viewError : String -> Html Msg
viewError errorMessage =
    let
        errorHeading =
            "Couldn't fetch data at this time."
    in
    div []
        [ h3 [] [ text errorHeading ]
        , text ("Error: " ++ errorMessage)
        ]


viewPosts : List Post -> Html Msg
viewPosts posts =
    div []
        [ h3 [] [ text "Posts" ]
        , table []
            ([ viewTableHeader ] ++ List.map viewPost posts)
        ]


viewTableHeader : Html Msg
viewTableHeader =
    tr []
        [ th []
            [ text "ID" ]
        , th []
            [ text "Title" ]
        , th []
            [ text "Author" ]
        ]


viewPost : Post -> Html Msg
viewPost post =
    tr []
        [ td []
            [ text (toString post.id) ]
        , td []
            [ text post.title ]
        , td []
            [ a [ href post.author.url ] [ text post.author.name ] ]
        ]


type Msg
    = SendHttpRequest
    | DataReceived (Result Http.Error (List Post))


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


httpCommand : Cmd Msg
httpCommand =
    list postDecoder
        |> Http.get "http://localhost:3000/posts"
        |> Http.send DataReceived


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendHttpRequest ->
            ( model, httpCommand )

        DataReceived (Ok posts) ->
            ( { model
                | posts = posts
                , errorMessage = Nothing
              }
            , Cmd.none
            )

        DataReceived (Err httpError) ->
            ( { model
                | errorMessage = Just (createErrorMessage httpError)
              }
            , Cmd.none
            )


createErrorMessage : Http.Error -> String
createErrorMessage httpError =
    case httpError of
        Http.BadUrl message ->
            message

        Http.Timeout ->
            "Server is taking too long to respond. Please try again later."

        Http.NetworkError ->
            "It appears you don't have an Internet connection right now."

        Http.BadStatus response ->
            response.status.message

        Http.BadPayload message response ->
            message


init : ( Model, Cmd Msg )
init =
    ( { posts = []
      , errorMessage = Nothing
      }
    , Cmd.none
    )


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
