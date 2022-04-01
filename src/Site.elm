module Site exposing (config)

import Copy.Keys exposing (Key(..))
import Copy.Text exposing (t)
import DataSource
import Head
import Pages.Manifest as Manifest
import Route
import SiteConfig exposing (SiteConfig)


type alias Data =
    ()


config : SiteConfig Data
config =
    { data = data
    , canonicalUrl = t SiteUrl
    , manifest = manifest
    , head = head
    }


data : DataSource.DataSource Data
data =
    DataSource.succeed ()


head : Data -> List Head.Tag
head static =
    [ Head.sitemapLink "/sitemap.xml"
    ]


manifest : Data -> Manifest.Config
manifest static =
    Manifest.init
        { name = t SiteTitle
        , description = t IndexPageMetaDescription
        , startUrl = Route.Index |> Route.toPath
        , icons = []
        }
