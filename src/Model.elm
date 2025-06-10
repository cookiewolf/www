module Model exposing (CaseStudy, Image, Model, Quote)

import Browser.Navigation
import Route exposing (Route)


type alias Model =
    { key : Browser.Navigation.Key
    , page : Route
    }


type alias Image =
    { src : String
    , alt : String
    }


type alias Quote =
    { quote : String
    , author : String
    , source : String
    }


type alias CaseStudy =
    { slug : String
    , title : String
    , introMarkdown : String
    , maybeIntroImage : Maybe Image
    , whatWeDidMarkdown : String
    , maybeWhatWeDidImage : Maybe Image
    , resultsMarkdown : String
    , maybeQuote : Maybe Quote
    }
