module View exposing (..)

import Html exposing (Html, h3, text)
import Misc exposing (findPostById)
import Types exposing (..)
import Views.Edit
import Views.List


view : Model -> Html Msg
view model =
    case model.currentRoute of
        PostsRoute ->
            Views.List.view model

        PostRoute id ->
            case findPostById id model.posts of
                Just post ->
                    Views.Edit.view post

                Nothing ->
                    notFoundView

        NotFoundRoute ->
            notFoundView


notFoundView : Html msg
notFoundView =
    h3 [] [ text "Oops! The page you requested was not found!" ]
