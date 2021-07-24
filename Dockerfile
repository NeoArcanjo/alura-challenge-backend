

FROM elixir:1.12.1
LABEL Name=alurachallengebackend Version=0.0.1
RUN apt-get -y update

RUN mkdir app
COPY . /app

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install hex phx_new 1.5.9 --force && \
    mix do deps.get, deps.compile
