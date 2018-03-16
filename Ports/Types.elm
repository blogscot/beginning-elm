module Types exposing (..)

import Json.Decode exposing (Value)


type alias Model =
    { dataFromJS : String
    , dataToJS : ComplexData
    , errorMessage : Maybe String
    }


type Msg
    = SendDataToJS
    | ReceivedDataFromJS Value


type alias ComplexData =
    { posts : List Post
    , comments : List Comment
    , profile : Profile
    }


type alias Post =
    { id : Int
    , title : String
    , author : Author
    }


type alias Author =
    { name : String
    , url : String
    }


type alias Comment =
    { id : Int
    , body : String
    , postId : Int
    }


type alias Profile =
    { name : String }
