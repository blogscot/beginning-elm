module Types exposing (..)

import Http
import Navigation exposing (Location)
import RemoteData exposing (WebData)


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
    { posts : WebData (List Post)
    , currentRoute : Route
    }


type alias PostId =
    Int


type alias Updater =
    String -> Post -> Post


type Msg
    = FetchPosts
    | PostsReceived (WebData (List Post))
    | OnLocationChange Location
    | UpdateTitle PostId String
    | UpdateAuthorName PostId String
    | UpdateAuthorUrl PostId String
    | SubmitUpdatedPost PostId
    | PostUpdated (Result Http.Error Post)


type Route
    = PostsRoute
    | PostRoute Int
    | NotFoundRoute
