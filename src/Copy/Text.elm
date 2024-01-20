module Copy.Text exposing (t)

import Copy.Keys exposing (Key(..))



-- The translate function


t : Key -> String
t key =
    case key of
        SiteUrl ->
            "https://cookiewolf.co.uk"

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
            "We’re a collective of developers, designers, researchers and other folk who understand digital tools, small organisation goals, sustainability and creative thinking. Our solutions focus on accessibility and inclusivity as well as delivering on a limited budget."

        WhatWeBelieveH2 ->
            "What we believe"

        WhatWeBelieveP ->
            """
 Collaboration and training is at the core of what we deliver. We work with you to feel confident about maintaining the tools we build together.

We are founders of [Code Reading Club CIC](https://codereading.club), putting reading skills at the forefront of a professional programmer's priorities. We foster a learning culture, allowing for everyone to do things at their own pace and with the support they need.
            """

        HowMuchWeCostH2 ->
            "What we cost"

        HowMuchWeCostP ->
            "We work with you to make the most of your budget. We make sure enough time lapses between decisions to give us the most considered outcome."

        HowMuchWeCostUl ->
            """
- **up to £1,000** (within a month) We can get you set up with a DIY solution or improve something you already have.
- **£5,000** (over a few months) We can build a small app or help you put together a basic website.
- **£20,000** (over 3-9 months) We can plan and prototype an idea you have and test it out or build a large website with a few bespoke features.
- **£60,000 +** (up to a year or more) We can do some in depth explorations and try out a few ideas, continuously making improvements in order to reach the best solution.
            """

        HowToContactUsH2 ->
            "How to contact us"

        HowToContactUsP ->
            "[hello@cookiewolf.co.uk](mailto:hello@cookiewolf.co.uk)"
