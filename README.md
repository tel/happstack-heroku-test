# Happstack on Heroku

A bare-bones, functional Happstack deploy on Heroku using @begriffs's [GHC Buildpack](https://github.com/begriffs/heroku-buildpack-ghc).

## Installation Instructions

### Launch on Heroku

1. Fork this repository
2. `heroku create --stack=cedar --buildpack https://github.com/begriffs/heroku-buildpack-ghc.git`
3. `git push heroku master`
