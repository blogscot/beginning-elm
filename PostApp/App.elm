module App exposing (main)

import Html exposing (program)
import State exposing (init, update)
import Types exposing (..)
import Views.ViewList exposing (view)


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
