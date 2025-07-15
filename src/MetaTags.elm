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
    case route of
        Route.AboutUs ->
            t Keys.AboutUsTitle ++ t Keys.SiteTitle

        _ ->
            t Keys.SiteTitle


metaForPage : Route.Route -> PageMetadata
metaForPage route =
    case route of
        Route.Index ->
            { title = titleForPage route
            , description = t Keys.HomeMetaDescription
            }

        Route.AboutUs ->
            { title = titleForPage route
            , description = t Keys.AboutUsMetaDescription
            }

        Route.CaseStudy slug ->
            let
                caseStudy =
                    Copy.CaseStudy.caseStudyIdFromSlug slug
                        |> Copy.CaseStudy.caseStudyFromId

                metaDescription =
                    case caseStudy.maybePageContent of
                        Just pageContent ->
                            pageContent.metaDescription

                        Nothing ->
                            t Keys.HomeMetaDescription
            in
            { title = caseStudy.title
            , description = metaDescription
            }


port setMetadata : PageMetadata -> Cmd msg
