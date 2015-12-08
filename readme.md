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

| 変数                    | 効果                                    |
|-------------------------|-----------------------------------------|
| %{year}                 | 本日の年 (e.g. 14)                      |
| %{Year}                 | 本日の年 (e.g. 2014)                    |
| - %{jyear}              | 本日の年度 (e.g. H26)                   |
| - %{Jyear}              | 本日の年度 (e.g. 平成26)                |
| - %{jfyear}             | 本日の会計年度(4月始まり) (e.g. H25)    |
| - %{Jfyear}             | 本日の会計年度(4月始まり) (e.g. 平成25) |
| %{month}                | 本日の月 (e.g. 06)                      |
| - %{Month}              | 本日の月 (e.g. Jun)                     |
| - %{Monthname}          | 本日の月 (e.g. June)                    |
| - %{Weekday}            | 本日の曜日 (e.g. Saturday)              |
| %{Week}                 | 本日の曜日 (e.g. Sat)                   |
| - %{weekday}            | 本日の曜日 (e.g. 土曜日)                |
| %{week}                 | 本日の曜日 (e.g. 土)                    |
| - %{cweek}              | (当月における)暦週 (e.g. 4)             |
| %{cWeek}                | 暦週 (e.g. 25)                          |
| %{day}                  | 本日の日 (e.g. 03)                      |
| %{me}                   | 自分の screen name (e.g. ken_c_lo)      |
| %{name}                 | 自分の名前 (e.g. Taeko Akatsuka)        |
| - %{team}               | チーム名                                |
