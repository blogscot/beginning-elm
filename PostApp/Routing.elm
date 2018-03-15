module Routing exposing (..)

import Navigation exposing (Location)
import Types exposing (..)
import UrlParser exposing (..)


extractRoute : Location -> Route
extractRoute location =
    case parsePath matchRoute location of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


matchRoute : Parser (Route -> a) a
matchRoute =
    oneOf
        [ map PostsRoute top
        , map PostsRoute (s "posts")
        , map PostRoute (s "posts" </> int)
        , map NewPostRoute (s "posts" </> s "new")
        ]
