port module MetaTags exposing (PageMetadata, metaForPage, setMetadata, titleForPage)

import Copy.CaseStudy
import Copy.Keys as Keys
import Copy.Text exposing (t)
import Route


type alias PageMetadata =
    { title : String
    , description : String
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
                    caseStudy.metaTitle ++ " - " ++ t Keys.CaseStudyTopLevelTitle

                _ ->
                    let
                        pageKey =
                            case route of
                                Route.Index ->
                                    Keys.SiteTitle

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
            , description = t Keys.HomeDescription
            }

        Route.AboutUs ->
            { title = titleForPage route
            , description = t Keys.AboutUsDescription
            }

        Route.CaseStudy slug ->
            let
                caseStudy =
                    Copy.CaseStudy.caseStudyIdFromSlug slug
                        |> Copy.CaseStudy.caseStudyFromId
            in
            { title = titleForPage route
            , description = caseStudy.metaDescription
            }


port setMetadata : PageMetadata -> Cmd msg
