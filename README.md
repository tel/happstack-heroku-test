# Happstack on Heroku

A bare-bones, functional Happstack deploy on Heroku using @begriffs's [GHC
Buildpack](https://github.com/begriffs/heroku-buildpack-ghc).

Right now it just implements a simple `echo` endpoint. See it live at
http://quiet-bastion-9641.herokuapp.com/echo/foo.

## Installation Instructions

### Launch on Heroku

1, 2, 3, and done!

1. Fork and clone
2. `heroku create --stack=cedar --buildpack https://github.com/begriffs/heroku-buildpack-ghc.git`
3. `git push heroku master`

## Notes

This is based off the first few paragraphs of the [Happstack Lite
Tutorial](http://happstack.com/page/view-page-slug/9/happstack-lite-tutorial),
but upgraded slightly to the "regular" `happstack-server` machinery.

Heroku requires that apps can configure their port via an environment variable.
`hktest` accepts the port configuration on its commandline (see the `Procfile`)
and uses the [`cmdargs`](hackage.haskell.org/package/cmdargs) package to do so.
See the `Config` subsection of `src/HKTest.hs` for more details.
