module App exposing (main)

import Navigation exposing (Location)
import State exposing (init, update)
import Types exposing (..)
import View exposing (view)


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
