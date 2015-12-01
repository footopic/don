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
GOOGLE_CLIENT_ID=""
GOOGLE_CLIENT_SECRET=""
```

``` setting up ImageMagic
yum install ImageMagick ImageMagick-devel
```


# import esa archive 2015/11/30 21:32
```
# unzip
unzip ./esa_archives/articles.zip -d ./esa_archives/articles

# run rake/task
./bin/rake archive:import_esa_io
```
