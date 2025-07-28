module Model exposing (CaseStudy, CaseStudyContent, Image, Model, ProfileInfo, Quote)

import Browser.Navigation
import Copy.Keys
import Route exposing (Route)
import Set exposing (Set)


type alias Model =
    { key : Browser.Navigation.Key
    , page : Route
    , openSections : Set String
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
    { name : String
    , title : String
    , teaserBackgroundSrc : String
    , teaserSummary : String
    , teaserLinkText : String
    , teaserHref : String
    , maybePageContent : Maybe CaseStudyContent
    }


type alias CaseStudyContent =
    { metaDescription : String
    , introMarkdown : String
    , maybeIntroImage : Maybe Image
    , whatWeDidMarkdown : String
    , maybeWhatWeDidImage : Maybe Image
    , resultsMarkdown : String
    , maybeQuote : Maybe Quote
    }


type alias ProfileInfo =
    { section : Copy.Keys.Section
    , name : String
    , role : String
    , bioMarkdown : String
    , projectsMarkdown : String
    , imagePath : String
    }
