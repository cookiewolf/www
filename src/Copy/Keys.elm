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
    | HomeTitle
    | WindowTitle String
    | Strapline
    | Category ContentType
    | HomeMetaDescription
    | WhatWeDoHeading
    | WhatWeDoMarkdown
    | ThingsWeWorkOnHeading
    | WhoWeAreHeading
    | WhoWeAreMarkdown1
    | WhoWeAreMarkdown2
      -- Case study
    | CaseStudyTitle
    | CaseStudySlug
      -- About Us
    | AboutUsSlug
    | AboutUsTitle
    | AboutUsMetaDescription
    | AboutUsSection Section
    | AboutUsProfileProjectsLabel
    | WhatWeDidHeading
    | ResultsHeading
      -- Footer
    | ContactUsHeading
    | ContactUsMarkdown
    | CompanyInformation
      -- blog bits
    | BlogSlug
    | BlogNotFoundThing
    | BlogHomeTitle
    | BlogHomeReadMoreLink
    | BlogIndexTitle
    | BlogMetaDescription
    | BlogCardReadMoreLink
    | BlogByLineBy
    | BlogByLineOn
      -- "not found" bits
    | NotFoundTitle
    | NotFoundThing
    | NotFoundDescription1 String
    | NotFoundDescription2
