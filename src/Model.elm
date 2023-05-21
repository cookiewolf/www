module Model exposing (Model)

import Browser
import Browser.Navigation
import Route exposing (Route)


type alias Model =
    { key : Browser.Navigation.Key
    , page : Route
    }
