# URL Shortener

## Build Instructions

If you have a recent version of Docker installed:
- To build and run the service:
  - `make`
- To run tests:
  - `make test`

If you have Elixir 1.14 installed and Postgres running locally :
- To build and run the service:
  - `mix deps.get`
  - `mix ecto.setup`
  - `mix phx.server`
- To run tests:
  - `mix test --cover`

Once running, head to [`http://localhost:4000/stats`](http://localhost:4000/stats) and play around with the URL shortener!

[Original instructions PDF](./Backend_Assessment_-_URL_Shortner_.pdf)

## TODO

Things I wanted to do but didn't have time:
- Full Elixir typespecs
- GitHub Action that runs linter, build, tests
- REST API pagination
- More LiveView tests
- More controller tests
- OpenAPI spec for REST API
  - Via https://github.com/open-api-spex/open_api_spex
- Property-based testing for URLs/hashes
  - Via https://github.com/alfert/propcheck
