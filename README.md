# www.cookiewolf.co

## Website for cookiewolf ltd

-  Staging URL: https://cookiewolf.netlify.app
-  Production URL: https://cookiewolf.co

# Development

## Prerequisites

- [node](https://nodejs.org/)
- [nvm for macOS & Linux](https://github.com/nvm-sh/nvm) or [nvm for Windows](https://github.com/coreybutler/nvm-windows)
- [yarn](https://yarnpkg.com/lang/en/docs/install)

## Setup & install instructions

- make sure you are using the correct node version with `nvm use`
- install with `npm install`i

## Build

- `yarn start` to start a dev server on http://localhost:3000
- `yarn build` generate a production build in `dist/`

## Formatting

We recommend integrating `elm-format@0.8.3` into your code editor, but if you don't...
- Please run `yarn format` to format `.elm` files in `src` before committing code.

## Testing

We're using elm-test-rs(https://github.com/mpizenberg/elm-test-rs) to run [elm tests](https://github.com/elm-explorations/test/)

-  run tests with `yarn test`

## Code & configs

### This site is built with `elm-pages`

- [Documentation site](https://elm-pages.com)
- [Elm Package docs](https://package.elm-lang.org/packages/dillonkearns/elm-pages/latest/)
- [`elm-pages` blog](https://elm-pages.com/blog)

### What it's for

- `elm.json` for elm packages used for site
- `elm-tooling.json` for elm packages used for code
- `package.json` for node scripts and packages
- `yarn.lock` for current versions of node packages
- `.nvmrc` contains project node version
- `.netlify.toml` for deploy config
- `tests/*` contains test files
- `public/*` contains static files to be copied direct to build
- `src/*` contains app source files

### Content & Pages

- TBC

### Styling & layouts

- TBC

## Deployment

Deploys to Netlify

-  code is tested and linted automatically before deploy
-  when a pull request is created, a preview site is deployed
-  when a pull request is merged into `main`, the production site is deployed

## Development workflow

### Adding issues

-  add effort & value labels (if you know enough about it)
-  put the issue in a milestone (if it is part of a current epic)

### Working on issue

-  assign it to yourself before starting work
-  make a branch that includes the issue type (fix/feat/chore etc & number)
-  make sure you understand the acceptance criteria
-  ask questions & make plan

### Code review & merge

-  check the acceptance criteria have been met
-  add comments & questions
-  once approved, leave for the author to squash and merge
