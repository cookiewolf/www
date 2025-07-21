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
    | HomeMetaDescription
    | WhatWeDoHeading
    | WhatWeDoMarkdown
    | ThingsWeWorkOnHeading
    | WhoWeAreHeading
    | WhoWeAreMarkdown1
    | WhoWeAreMarkdown2
      -- About Us
    | AboutUsSlug
    | AboutUsTitle
    | AboutUsMetaDescription
    | AboutUsSection Section
    | AboutUsProfileProjectsLabel
    | CaseStudySlug
    | WhatWeDidHeading
    | ResultsHeading
      -- Footer
    | ContactUsHeading
    | ContactUsMarkdown
    | CompanyInformation
