module Copy.Text exposing (t)

import Copy.Keys exposing (ContentType(..), Key(..))



-- The translate function


t : Key -> String
t key =
    case key of
        SiteTitle ->
            "Cookiewolf"

        Strapline ->
            "Building useful digital tools with you"

        Category contentType ->
            (case contentType of
                CaseStudy ->
                    "Case Study"
            )
                ++ ":"

        WhatWeDoH2 ->
            "What We Do"

        WhatWeDoMarkdown ->
            """
**Cookiewolf** is a cooperatively-run digital development and design studio. We work with organizations of all sizes.

Our projects are based in true collaboration with our clients, focusing on accessibility, sustainability and inclusivity, delivered on a limited budget.
            """

        WhoWeAreH2 ->
            "Who we are"

        WhoWeAreMarkdown1 ->
            """
An experienced group of developers, designers, writers, and other folk who’ve come together to form a collective. Cookiewolf Co-op reflects how we think businesses should be run, based in equity, flexibility and creative thinking.
            """

        WhoWeAreMarkdown2 ->
            """
Our members’ award-winning work spans medium to large-scale projects with clients across the arts, third sector, B2B, social justice and retail sectors.

[Meet the people behind Cookiewolf](/about-us)
            """

        ThingsWeWorkOnH2 ->
            "Things We're Working On"

        ContactUsH2 ->
            "Contact Us"

        ContactUsMarkdown ->
            """
Got a project? Questions? Just want a chat? Email us at:

[hello@cookiewolf.coop](mailto:hello@cookiewolf.coop)
            """

        CompanyInformation ->
            "Cookiewolf Co-op Ltd is registered in England & Wales (No. 13865007)"

        CaseStudySlug ->
            "case-study"
