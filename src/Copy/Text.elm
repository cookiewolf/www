module Copy.Text exposing (t)

import Copy.Keys exposing (Key(..))



-- The translate function


t : Key -> String
t key =
    case key of
        SiteUrl ->
            "https://cookiewolf.org"

        SiteTitle ->
            "Cookiewolf"

        --- Site Meta
        IndexPageMetaTitle ->
            "Home"

        IndexPageMetaDescription ->
            "Cookiewolf builds digital tools."

        WhatWeDoH2 ->
            "What we do"

        WhatWeDoP ->
            "We work with small organisations and people to discover, design and build the digital tools they need."

        WhoWeAreH2 ->
            "Who we are"

        WhoWeAreP ->
            "We have over 15 years experience helping small groups of people and individuals use tech to deliver the services they know people and things they care about need."

        WhatWeBelieve ->
            "Collaboration and training is at the core of what we deliver. Code Reading Club. Learning culture. Work with you to feel confident about maintaining the tools we build."

        HowToContactUs ->
            ""
