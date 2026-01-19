module Model exposing (BlogPost, CaseStudy, CaseStudyContent, Image, Model, PageMetadata, PageResource, ProfileInfo, Quote, emptyCaseStudy, emptyCaseStudyContent, emptyPageMetadata, emptyPageResource)

import Array exposing (Array)
import Browser.Navigation
import Copy.Keys
import Route exposing (Route)
import Set exposing (Set)


type alias PageMetadata =
    { title : String
    , description : String
    , url : Maybe String
    , imageSrc : Maybe String
    }


emptyPageMetadata : PageMetadata
emptyPageMetadata =
    { title = ""
    , description = ""
    , url = Nothing
    , imageSrc = Nothing
    }


type alias Model =
    { key : Browser.Navigation.Key
    , page : Route
    , viewportHeightWidth : ( Float, Float )
    , openSections : Set String
    , blogPosts : Array BlogPost
    , pageResource : PageResource
    }


type alias PageResource =
    { blogPost : Maybe BlogPost
    , caseStudy : Maybe CaseStudy
    , meta : PageMetadata
    }


emptyPageResource : PageResource
emptyPageResource =
    { blogPost = Nothing
    , caseStudy = Nothing
    , meta = emptyPageMetadata
    }


type alias BlogPost =
    { slug : String
    , author : String
    , publishDate : String -- YYYY-MM-DD
    , title : String
    , teaser : String
    , keywords : String
    , content : String
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
    , metaTitle : String
    , metaUrl : Maybe String
    , metaImageSrc : Maybe String
    }


emptyCaseStudy : CaseStudy
emptyCaseStudy =
    { name = ""
    , title = ""
    , teaserBackgroundSrc = ""
    , teaserSummary = ""
    , teaserLinkText = ""
    , teaserHref = ""
    , maybePageContent = Nothing
    , metaTitle = ""
    , metaUrl = Nothing
    , metaImageSrc = Nothing
    }


type alias CaseStudyContent =
    { introMarkdown : String
    , metaDescription : String
    , maybeIntroImage : Maybe Image
    , whatWeDidMarkdown : String
    , maybeWhatWeDidImage : Maybe Image
    , resultsMarkdown : String
    , maybeQuote : Maybe Quote
    }


emptyCaseStudyContent : CaseStudyContent
emptyCaseStudyContent =
    { introMarkdown = ""
    , metaDescription = ""
    , maybeIntroImage = Nothing
    , whatWeDidMarkdown = ""
    , maybeWhatWeDidImage = Nothing
    , resultsMarkdown = ""
    , maybeQuote = Nothing
    }


type alias ProfileInfo =
    { section : Copy.Keys.Section
    , name : String
    , role : String
    , bioMarkdown : String
    , projectsMarkdown : String
    , imagePath : String
    }
