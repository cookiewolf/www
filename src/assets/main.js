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
