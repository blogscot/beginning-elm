module App exposing (main)

import Navigation exposing (Location)
import State exposing (init, updateWithStorage)
import Types exposing (..)
import View exposing (view)


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = updateWithStorage
        , subscriptions = always Sub.none
        }
