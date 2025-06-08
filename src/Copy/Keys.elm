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
    | WhatWeDoHeading
    | WhatWeDoMarkdown
    | ThingsWeWorkOnHeading
    | WhoWeAreHeading
    | WhoWeAreMarkdown1
    | WhoWeAreMarkdown2
      -- Case Study
    | CaseStudySlug
    | WhatWeDidHeading
    | ResultsHeading
      -- Footer
    | ContactUsHeading
    | ContactUsMarkdown
    | CompanyInformation
