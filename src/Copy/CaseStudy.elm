module Copy.CaseStudy exposing (CaseStudy, CaseStudyKey(..), caseStudyFromId, caseStudyIdFromSlug)


type alias CaseStudy =
    { slug : String
    , title : String
    , introMarkdown : String
    }


type CaseStudyKey
    = Foyer
    | FourZeroFour


caseStudyIdFromSlug : String -> CaseStudyKey
caseStudyIdFromSlug slug =
    case slug of
        "foyer" ->
            Foyer

        _ ->
            FourZeroFour


caseStudyFromId : CaseStudyKey -> CaseStudy
caseStudyFromId id =
    case id of
        Foyer ->
            foyer

        FourZeroFour ->
            fourZeroFour


foyer : CaseStudy
foyer =
    { slug = "foyer"
    , title = "Transforming The Foundling Museum's digital infrastructure with Foyer"
    , introMarkdown =
        """
**Cookiewolf’s Stuart Leech led the Foundling Museum’s digital transformation, collaborating with lead developer Katja Mordaunt to build a bespoke version of Foyer, our Shopify-based ticketing system.**

**Foyer was a key part of a broader digital transformation, designed to help a small organisation create a big impact with tailored solutions.**

The Foundling Museum came to us with numerous challenges:

- Their ticketing system had a fractured payment journey that didn’t extract useful customer data.
- Customers rarely chose to add Gift Aid when buying a ticket.
- The system lacked up-to-date payment options, like Apple Pay.
- The museum had no CRM system, so wider museum systems including point-of-sale, e-commerce and finance, didn’t have a fast or smooth information flow. In fact, museum employees often had to transfer data manually.
        """
    }


fourZeroFour : CaseStudy
fourZeroFour =
    { slug = ""
    , title = "Not found"
    , introMarkdown = "[Page not found](/)"
    }
