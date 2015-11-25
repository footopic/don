footopic web prototype
===

# Installation

install

```sh
# bundler
bundle install

# bower-rails
./bin/rake bower:install

./bin/rake db:migrate

```

edit key setting

```sh
vim ./.env

```

```sh:.env
TWITTER_CONSUMER_KEY="********"
TWITTER_CONSUMER_SECRET="********"
```

```setup ImageMagick
yum -y install libjpeg-devel libpng-devel
yum -y install ImageMagick ImageMagic-devel
```
