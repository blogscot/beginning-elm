module Views.Edit exposing (view)

import Html exposing (..)
import Html.Attributes exposing (href, type_, value)
import Types exposing (..)


view : Post -> Html Msg
view post =
    div []
        [ a [ href "/posts" ] [ text "Back" ]
        , h3 []
            [ text "Edit Post" ]
        , editForm post
        ]


editForm : Post -> Html Msg
editForm post =
    Html.form []
        [ div []
            [ text "Title"
            , br [] []
            , input
                [ type_ "text"
                , value post.title
                ]
                []
            ]
        , br [] []
        , div []
            [ text "Author Name"
            , br [] []
            , input
                [ type_ "text"
                , value post.author.name
                ]
                []
            ]
        , br [] []
        , div []
            [ text "Author URL"
            , br [] []
            , input
                [ type_ "text"
                , value post.author.url
                ]
                []
            ]
        , br [] []
        , div []
            [ button []
                [ text "Submit" ]
            ]
        ]
