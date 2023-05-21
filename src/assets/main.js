import "./reset.css";
import { Elm } from "../Main.elm";
import '@fontsource/chau-philomene-one';
import '@fontsource/sono';

if (process.env.NODE_ENV === "development") {
    const ElmDebugTransform = await import("elm-debug-transformer")

    ElmDebugTransform.register({
        simple_mode: true
    })
}

const root = document.querySelector("#app div");
const app = Elm.Main.init({ node: root });
