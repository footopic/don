footopic web prototype
===

# Installation

install

```sh
# bundler
bundle install

# migration (sqlite3 in dev)
./bin/rake db:migrate
./bin/rake db:seed_fu

# npm
npm install

```

edit key setting

```sh
vim ./.env

```

```sh:.env
TWITTER_CONSUMER_KEY="********"
TWITTER_CONSUMER_SECRET="********"
```
