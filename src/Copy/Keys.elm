module Copy.Keys exposing (ContentType(..), Key(..))


type ContentType
    = CaseStudy


type
    Key
    -- Header
    = SiteTitle
    | Strapline
    | Category ContentType
      -- Home
    | WhatWeDoH2
    | WhatWeDoMarkdown
    | ThingsWeWorkOnH2
    | WhoWeAreH2
    | WhoWeAreMarkdown1
    | WhoWeAreMarkdown2
      -- Case Study
    | CaseStudySlug
      -- Footer
    | ContactUsH2
    | ContactUsMarkdown
    | CompanyInformation
