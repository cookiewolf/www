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
            "Cookiewolf builds digital tools in collaboration with you."

        Strapline ->
            "Building useful stuff online, together"

        WhatWeDoH2 ->
            "What we do"

        WhatWeDoP ->
            "We work with small organisations and people to discover, design and build the digital tools they need."

        WhoWeAreH2 ->
            "Who we are"

        WhoWeAreP ->
            "We have over 15 years experience helping small groups of people and individuals use tech to deliver the services they know people and things they care about need."

        WhatWeBelieveH2 ->
            "What we believe"

        WhatWeBelieveP ->
            "Collaboration and training is at the core of what we deliver.We work with you to feel confident about maintaining the tools we build together. We are founders of [Code Reading Club](https://codereading.club), putting reading skills at the forefront of a professional programmer's priorities. We foster a learning culture, allowing for everyone to do things at their own pace and with the support they need."

        HowMuchWeCostH2 ->
            "What we cost"

        HowMuchWeCostP ->
            "We charge £350 for a day of our time. We are happy to negotiate if your job is very small or very big."

        HowToContactUsH2 ->
            "How to contact us"

        HowToContactUsP ->
            "[hello@cookiewolf.org](mailto:hello@cookiewolf.org)"
