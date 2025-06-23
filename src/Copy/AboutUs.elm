module Copy.AboutUs exposing (profiles)

import Copy.Keys exposing (Section(..))
import Model


profiles : List Model.ProfileInfo
profiles =
    [ alfie, emma, ivan, karl, katja, nick, rebecca, stuart ]


alfie : Model.ProfileInfo
alfie =
    { section = DigitalDevelopment
    , name = "Alfie"
    , role = ""
    , bioMarkdown = ""
    , projectsMarkdown = ""
    }


emma : Model.ProfileInfo
emma =
    { section = ContentAndDesign
    , name = "Emma"
    , role = ""
    , bioMarkdown = ""
    , projectsMarkdown = ""
    }


ivan : Model.ProfileInfo
ivan =
    { section = DigitalDevelopment
    , name = "Ivan"
    , role = ""
    , bioMarkdown = ""
    , projectsMarkdown = ""
    }


karl : Model.ProfileInfo
karl =
    { section = Business
    , name = "Karl"
    , role = "Delivery Manager & Software Tester"
    , bioMarkdown = ""
    , projectsMarkdown = ""
    }


katja : Model.ProfileInfo
katja =
    { section = DigitalDevelopment
    , name = "Katja"
    , role = ""
    , bioMarkdown = ""
    , projectsMarkdown = ""
    }


nick : Model.ProfileInfo
nick =
    { section = DigitalDevelopment
    , name = "Nick"
    , role = ""
    , bioMarkdown = ""
    , projectsMarkdown = ""
    }


rebecca : Model.ProfileInfo
rebecca =
    { section = ContentAndDesign
    , name = "Rebecca"
    , role = ""
    , bioMarkdown = ""
    , projectsMarkdown = ""
    }


stuart : Model.ProfileInfo
stuart =
    { section = Business
    , name = "Stuart"
    , role = "Business Development & Digital Specialist"
    , bioMarkdown = """
Stuart is a UX and service design specialist with a focus on project and product management. As a visual artist himself, he's particularly interested in working on digital projects for arts and social justice organisations.  Stuart's work with Foyer has also seen him nominated for multiple awards, including being longlisted for the 'Digital Ambassador' award in the 2025 Digital Cultural Awards.
    """
    , projectsMarkdown = """
 The Foundling Museum, South London Gallery, Art UK, Surviving Economic Abuse, Standing Together Against Domestic Abuse, Manchester Museum.
    """
    }
