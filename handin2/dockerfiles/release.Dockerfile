FROM elixir:1.14.0-alpine AS base

WORKDIR /app

ENV MIX_ENV dev

COPY handin2/mix.exs .
COPY handin2/mix.lock .
COPY handin2/config config
COPY handin2/lib lib
COPY handin2/priv priv

RUN apk get update && apk add git
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix compile

RUN mix release

ENTRYPOINT [ "mix", "run", "--no-halt" ]