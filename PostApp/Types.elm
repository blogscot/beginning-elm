module Types exposing (..)

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


type Msg
    = FetchPosts
    | PostsReceived (WebData (List Post))
    | OnLocationChange Location


type Route
    = PostsRoute
    | PostRoute Int
    | NotFoundRoute
