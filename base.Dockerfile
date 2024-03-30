FROM debian:12.5-slim

ENV PORT 4000

WORKDIR /app

# Get updates and get node.js and npm
RUN apt update && apt install -y nodejs npm

# Install Elixir
RUN apt install -y inotify-tools git bash make gcc libc-dev erlang-dev elixir erlang-xmerl

RUN mix do local.hex --force, local.rebar --force
COPY mix.exs mix.lock ./
RUN MIX_ENV=prod mix do deps.get, deps.compile && mkdir assets

COPY assets/package.json assets/package-lock.json ./assets/
RUN cd assets && npm install; cd -

ENTRYPOINT mix ecto.create && mix ecto.migrate && mix phx.server
