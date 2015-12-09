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
GOOGLE_CLIENT_ID=""
GOOGLE_CLIENT_SECRET=""
```

# Deploy
## staging

setup sshkey ~/.ssh/footopic

```sh
# deploy
cap staging deploy

# rollback
cap staging deploy

# run task (hoge:fuga)
cap staging remote_rake:invoke task=hoge:fuga
```


# Task
## archive:import_esa_io
/import に md ファイルを設置

```
# run rake/task
./bin/rake archive:import_esa_io
```


# テンプレート変数メモ

| 変数                      | 効果               | 例         |
|---------------------------|--------------------|------------|
| %{year}                   | 本日の年           | 15         |
| %{Year}                   | 本日の年           | 2015       |
| %{month}                  | 本日の月           | 12         |
| %{day}                    | 本日の日           | 09         |
| %{week}                   | 本日の曜日         | Wed        |
| %{cDay}                   | 暦日               | 343        |
| %{cWeek}                  | 暦週               | 50         |
| %{me}                     | 自分の screen name | hiro       |
| %{name}                   | 自分の名前         | 高橋洸人   |
