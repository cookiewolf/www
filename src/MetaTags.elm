port module MetaTags exposing
    ( metaForAboutUs
    , metaForBlogIndex
    , metaForBlogShowPost
    , metaForCaseStudy
    , metaForNotFound
    , metaForRoot
    , setMetadata
    )

import Copy.Keys as Keys
import Copy.Text exposing (t)
import Model exposing (PageMetadata)


metaForRoot : PageMetadata
metaForRoot =
    { title = t <| Keys.WindowTitle <| t Keys.HomeTitle
    , description = t Keys.HomeMetaDescription
    , url = Nothing
    , imageSrc = Nothing
    }


metaForAboutUs : PageMetadata
metaForAboutUs =
    { title = t <| Keys.WindowTitle <| t Keys.AboutUsTitle
    , description = t Keys.AboutUsMetaDescription
    , url = Nothing
    , imageSrc = Nothing
    }


metaForCaseStudy : Model.CaseStudy -> PageMetadata
metaForCaseStudy caseStudy =
    let
        metaDescription =
            case caseStudy.maybePageContent of
                Just pageContent ->
                    pageContent.metaDescription

                Nothing ->
                    t Keys.HomeMetaDescription
    in
    { title = t <| Keys.WindowTitle <| caseStudy.title -- could be caseStudie.title ++ " - " ++ t Keys.CaseStudyTitle
    , description = metaDescription
    , url = caseStudy.metaUrl
    , imageSrc = caseStudy.metaImageSrc
    }


metaForBlogIndex : PageMetadata
metaForBlogIndex =
    { title = t <| Keys.WindowTitle <| t Keys.BlogIndexTitle
    , description = t Keys.BlogMetaDescription
    , url = Nothing
    , imageSrc = Nothing
    }


metaForBlogShowPost : Model.BlogPost -> PageMetadata
metaForBlogShowPost post =
    { title = t <| Keys.WindowTitle <| post.title
    , description = post.teaser
    , url = Nothing
    , imageSrc = Nothing
    }


metaForNotFound : String -> PageMetadata
metaForNotFound thing =
    { title = t <| Keys.WindowTitle <| t Keys.NotFoundTitle
    , description = t <| Keys.NotFoundDescription1 thing
    , url = Nothing
    , imageSrc = Nothing
    }


port setMetadata : PageMetadata -> Cmd msg
