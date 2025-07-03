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
    , role = "Full Stack Developer & DevOps"
    , bioMarkdown = """
Alfie believes that problems are best solved by giving those affected the tools and resources to do so for themselves. He has worked on building infrastructure that promotes community autonomy and resilience for many years. Previously physically and materially, currently digitally.
    """
    , projectsMarkdown = """
Ivan and Alfie had key development roles on PlaceCal, an award-winning community calendar system, developed with Geeks for Social Change and used by communities like TransDimension and Manchester Age Friendly Neighbourhoods.
    """
    , imagePath = "/src/assets/people/alfie.jpg"
    }


emma : Model.ProfileInfo
emma =
    { section = ContentAndDesign
    , name = "Emma"
    , role = "Graphic Designer, Illustrator & UX Designer"
    , bioMarkdown = """
Emma has over a decade of experience working across the education, arts, culture and charity sectors. [Her graphic and branding work](https://www.emmacharleston.co.uk/) spans print and digital, website and app wireframes, qualitative and quantitative user and client research. She’s particularly interested in collaborative and community-led design practice that’s informed by local circumstance and experience. 
    """
    , projectsMarkdown = """
    The Wildlife Trusts, The Bishopsgate Institute, Happy Valley Pride, Kings Education, Hopscotch Consultancy, The Global Returns Project, Build Concierge, Central London Samaritans
    """
    , imagePath = "/src/assets/people/emma.jpg"
    }


ivan : Model.ProfileInfo
ivan =
    { section = DigitalDevelopment
    , name = "Ivan"
    , role = "Full Stack Developer & DevOps"
    , bioMarkdown = """
 Ivan’s focus is software engineering with Ruby on Rails, perl, labview, common lisp and unity. He's also had stabs at javascript and python. He’s interested in Tech for Good and generally fostering community among the queer, nerdy and disabled.
    """
    , projectsMarkdown = """
Ivan and Alfie had key development roles on PlaceCal, an award-winning community calendar system, developed with Geeks for Social Change and used by communities like TransDimension and Manchester Age Friendly Neighbourhoods.
    """
    , imagePath = "/src/assets/people/ivan.jpg"
    }


karl : Model.ProfileInfo
karl =
    { section = Business
    , name = "Karl"
    , role = "Delivery Manager & Software Tester"
    , bioMarkdown = """
Karl has 30 years’ experience in the tech industry working in financial services and the charity sector. He’s interested in tech projects that empower people, including those who don’t see themselves as ‘techy’  to access help when they need it most. 
    """
    , projectsMarkdown = """
[Alexandra Rose Charity](https://www.alexandrarose.org.uk/), delivering digital infrastructure, replacing a paper-based system, streamlining the existing voucher distribution process to give low-income families access to fresh fruit and vegetables. Other projects include: The Haven, and the [DocReady app](https://docready.org), a Comic Relief lab project.
    """
    , imagePath = "/src/assets/people/karl.jpg"
    }


katja : Model.ProfileInfo
katja =
    { section = DigitalDevelopment
    , name = "Katja"
    , role = "Full Stack Developer & Project Lead"
    , bioMarkdown = """
Katja’s career has spanned many interests and industries but currently she designs and implements digital services and browser-based tools that help improve the reach of charities and community organisations. She values a culture of collaboration, open source, transparency, integrity, sharing stuff and giving everyone a chance at meaningful participation. 
    """
    , projectsMarkdown = """
Darts, a series of web games created with Nick for an arts charity on a small budget. You can play them [here](https://games.thepoint.org.uk/). Other recent work includes: Radical Routes, Surviving Economic Abuse, Farm Carbon Calculator
    """
    , imagePath = "/src/assets/people/katja.jpg"
    }


nick : Model.ProfileInfo
nick =
    { section = DigitalDevelopment
    , name = "Nick"
    , role = "Front-end Web Developer"
    , bioMarkdown = """
Nick’s background is in games development and he likes to work on projects that genuinely help people, He values semantically correct HTML, creating responsive layouts with CSS and has a special interest in web accessibility.
    """
    , projectsMarkdown = """
[Mind of my Own](https://mindofmyown.org.uk/): By the end of this six-year project with Neontribe, Nick had become Lead Front-end Developer, creating apps that make it safe and intuitive for young people living within the care system to raise safeguarding concerns.
    """
    , imagePath = "/src/assets/people/nick.jpg"
    }


rebecca : Model.ProfileInfo
rebecca =
    { section = ContentAndDesign
    , name = "Rebecca"
    , role = "Writer & Content Designer"
    , bioMarkdown = """
Rebecca has worked as a copywriter, bid writer, editor and content designer for over a decade, working on everything from editing poetry anthologies written by at-risk young people, to user-focused copy for websites and apps.
    """
    , projectsMarkdown = """
Shelter, UsVsTh3m; bid writing for Geeks for Social Change and agency work for Saatchi & Saatchi pro, Agency Inc and Pebble Studios.
    """
    , imagePath = "/src/assets/people/rebecca.jpg"
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
    , imagePath = "/src/assets/people/stuart.jpg"
    }
