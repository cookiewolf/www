port module MetaTags exposing (PageMetadata, setMetadata, metaForPage, titleForPage)
import Route
import Copy.Text exposing (t)
import Copy.Keys as Keys

type alias PageMetadata =
    { title : String
    , description : String
    }

titleForPage : Route.Route -> String
titleForPage route =
    let
        pageKey =
            case route of
                Route.Index ->
                    Keys.SiteTitle

                Route.AboutUs ->
                    Keys.AboutUsTitle

                Route.CaseStudy _ ->
                    Keys.CaseStudyTitle
    in
      (t pageKey) ++ " - " ++ (t Keys.SiteTitle)



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

        Route.CaseStudy _ ->
            { title = titleForPage route
            , description = t Keys.CaseStudyDescription
            }


port setMetadata : PageMetadata -> Cmd msg