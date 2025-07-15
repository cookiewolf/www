module Copy.CaseStudy exposing (CaseStudyKey(..), caseStudyFromId, caseStudyIdFromSlug)

import Model
import Route


type CaseStudyKey
    = CodeReadingClub
    | Foyer
    | NewProjectInvite
    | FourZeroFour


caseStudyIdFromSlug : String -> CaseStudyKey
caseStudyIdFromSlug slug =
    case slug of
        "foyer" ->
            Foyer

        _ ->
            FourZeroFour


caseStudyFromId : CaseStudyKey -> Model.CaseStudy
caseStudyFromId id =
    case id of
        CodeReadingClub ->
            codeReadingClub

        Foyer ->
            foyer

        NewProjectInvite ->
            newProjectInvite

        FourZeroFour ->
            fourZeroFour


codeReadingClub : Model.CaseStudy
codeReadingClub =
    { title = "Code Reading Club"
    , maybeTeaserLogoSrc = Nothing
    , teaserBackgroundSrc = "/work/woven_loops.png"
    , teaserSummary = "Like a book group, but for coders. We devise and facilitate inclusive, live workshops for developers of all skill levels to connect and sharpen their skills."
    , teaserLinkText = "Find out more"
    , teaserHref = "https://codereading.club"
    , maybePageContent = Nothing
    }


foyer : Model.CaseStudy
foyer =
    { title = "Transforming The Foundling Museum's digital infrastructure with Foyer"
    , maybeTeaserLogoSrc = Just "/foyer_logo.png"
    , teaserBackgroundSrc = "/work/ancient_arches.png"
    , teaserSummary = "Foyer, our award-winning bespoke ticketing platform that helps organisations simplify systems and create faster, better visitor experiences."
    , teaserLinkText = "Read our case study"
    , teaserHref = Route.toString (Route.CaseStudy "foyer")
    , maybePageContent =
        Just
            { metaDescription = "Foyer Description [cCc]"
            , introMarkdown =
                """
**Cookiewolf's Stuart Leech led the Foundling Museum's digital transformation, collaborating with lead developer Katja Mordaunt to build a bespoke version of Foyer, our Shopify-based ticketing system.**

**Foyer was a key part of a broader digital transformation, designed to help a small organisation create a big impact with tailored solutions.**

The Foundling Museum came to us with numerous challenges:

- Their ticketing system had a fractured payment journey that didn't extract useful customer data.
- Customers rarely chose to add Gift Aid when buying a ticket.
- The system lacked up-to-date payment options, like Apple Pay.
- The museum had no CRM system, so wider museum systems including point-of-sale, e-commerce and finance, didn't have a fast or smooth information flow. In fact, museum employees often had to transfer data manually.
        """
            , maybeIntroImage = Nothing
            , whatWeDidMarkdown =
                """
Our custom Foyer solution was developed in close collaboration with key stakeholders at The Foundling Museum. We worked together iteratively and identified the underlying problem — too many complex systems that weren't working together.

**Our aim:** To create a seamless payment flow so museum professionals could focus on enhancing visitors' experience, rather than wrangling systems.

- Foyer enabled an integrated digital ecosystem for the Museum, and we installed a CRM that streamlined data flow between systems and gave the Museum a 360 view of their visitors.
- Implementing no-code tools like Zapier allowed us to simplify systems and enable consistent data flow without expensive time and development cost.
- We worked directly with the Foundling Museum’s teams, breaking down silos that caused mistrust in data. We also identified staff members to support the CRM and focus specifically on clear communication between departments.
        """
            , maybeWhatWeDidImage = Nothing
            , resultsMarkdown =
                """
We’re really proud of what Foyer accomplished for The Foundling Museum, particularly the impact it had on ticket sales and customer engagement:

- Gift Aid uptake went from 5% to 35%
- 34% increase in Foundling Museum newsletter subscriptions
- Enhanced operational efficiency
- Reduced data silos with improved reporting
- More visitor payment options, including mobile wallets and installment payments

Foyer's payment journey for the Foundling Museum has been recognised by Arts Council England as: "a really effective and speedy ticketing journey."

[Watch a demonstration of Foyer's payment flow in ACE's Digital Culture Network presentation.](https://www.youtube.com/watch?si=EDYndMkpQohlOIdS&t=1318&v=98nYKjKarEg)

[The work we did was also shortlisted in the "Using Data" category at the 2025 Digital Cultural Awards.](https://digitalculturenetwork.org.uk/awards/)
        """
            , maybeQuote = Nothing
            }
    }


newProjectInvite : Model.CaseStudy
newProjectInvite =
    { title = "Your Project here?"
    , maybeTeaserLogoSrc = Nothing
    , teaserBackgroundSrc = "/litle_bird_big_object.png"
    , teaserSummary = "We're always up for working with folks who are building new things or making old things work better. Wherever you're at, we'd love to chat."
    , teaserLinkText = "Get in touch (hello@cookiewolf.coop)"
    , teaserHref = "mailto:hello@cookiewolf.coop"
    , maybePageContent = Nothing
    }


fourZeroFour : Model.CaseStudy
fourZeroFour =
    { title = "Project not found"
    , maybeTeaserLogoSrc = Nothing
    , teaserBackgroundSrc = ""
    , teaserSummary = ""
    , teaserLinkText = ""
    , teaserHref = "mailto:hello@cookiewolf.coop"
    , maybePageContent = Nothing
    }
