import './reset.css';
import { Elm } from '../Main.elm';
import '@fontsource/poppins/400.css';
import '@fontsource/poppins/800.css';

if (process.env.NODE_ENV === 'development') {
  const ElmDebugTransform = await import('elm-debug-transformer');

  ElmDebugTransform.register({
    simple_mode: true,
  });
}

const root = document.querySelector('#app div');
const app = Elm.Main.init({ node: root });

app.ports.setMetadata.subscribe(function (pageMetadata) {
  const baseUrl =
    import.meta.env.VITE_BASE_URL ?? "https://cookiewolf.coop";
  const defaultImage = `${baseUrl}/meta-image.png`;
  const defaultUrl = baseUrl;

  console.log("setting metadata to: ", pageMetadata);

  if (pageMetadata.hasOwnProperty("title")) {
    document.title = pageMetadata.title;
    document
      .getElementsByTagName("meta")
      .namedItem("og-title")
      .setAttribute("content", pageMetadata.title);
  }

  if (pageMetadata.hasOwnProperty("description")) {
    document
      .getElementsByTagName("meta")
      .namedItem("description")
      .setAttribute("content", pageMetadata.description);
    document
      .getElementsByTagName("meta")
      .namedItem("og-description")
      .setAttribute("content", pageMetadata.description);
  }

  document
    .getElementsByTagName("meta")
    .namedItem("og-url")
    .setAttribute("content", pageMetadata.url || defaultUrl);

  let image = defaultImage;
  if (pageMetadata.hasOwnProperty("imageSrc")) {
    image = baseUrl + pageMetadata.imageSrc;
  }

  document
    .getElementsByTagName("meta")
    .namedItem("og-image")
    .setAttribute("content", image);

});