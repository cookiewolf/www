module Copy.Keys exposing (ContentType(..), Key(..), Section(..))


type ContentType
    = CaseStudy


type Section
    = Business
    | ContentAndDesign
    | DigitalDevelopment


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
      -- About Us
    | AboutUsSlug
    | AboutUsTitle
    | AboutUsSection Section
    | AboutUsProfileProjectsLabel
      -- Case Study
    | CaseStudySlug
    | WhatWeDidHeading
    | ResultsHeading
      -- Footer
    | ContactUsHeading
    | ContactUsMarkdown
    | CompanyInformation
