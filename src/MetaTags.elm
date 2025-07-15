port module MetaTags exposing (PageMetadata, metaForPage, setMetadata, titleForPage)

import Copy.CaseStudy
import Copy.Keys as Keys
import Copy.Text exposing (t)
import Route


type alias PageMetadata =
    { title : String
    , description : String
    , url : Maybe String
    , imageSrc : Maybe String
    }


titleForPage : Route.Route -> String
titleForPage route =
    let
        pageTitle =
            case route of
                Route.CaseStudy slug ->
                    let
                        caseStudy =
                            Copy.CaseStudy.caseStudyIdFromSlug slug
                                |> Copy.CaseStudy.caseStudyFromId
                    in
                    caseStudy.metaTitle ++ " - " ++ t Keys.CaseStudyMetaTitle

                _ ->
                    let
                        pageKey =
                            case route of
                                Route.Index ->
                                    Keys.HomeMetaTitle

                                Route.AboutUs ->
                                    Keys.AboutUsTitle

                                _ ->
                                    Keys.SiteTitle
                    in
                    t pageKey
    in
    pageTitle ++ " - " ++ t Keys.SiteTitle


metaForPage : Route.Route -> PageMetadata
metaForPage route =
    case route of
        Route.Index ->
            { title = titleForPage route
            , description = t Keys.HomeMetaDescription
            , url = Nothing
            , imageSrc = Nothing
            }

        Route.AboutUs ->
            { title = titleForPage route
            , description = t Keys.AboutUsMetaDescription
            , url = Nothing
            , imageSrc = Nothing
            }

        Route.CaseStudy slug ->
            let
                caseStudy =
                    Copy.CaseStudy.caseStudyIdFromSlug slug
                        |> Copy.CaseStudy.caseStudyFromId
            in
            { title = titleForPage route
            , description = caseStudy.metaDescription
            , url = caseStudy.metaUrl
            , imageSrc = caseStudy.metaImageSrc
            }


port setMetadata : PageMetadata -> Cmd msg
