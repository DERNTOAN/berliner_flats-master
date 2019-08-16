# README
​
This README would normally document whatever steps are necessary to get the
application up and running.
​
Things you may want to cover:
​
* Ruby version 2.6.3 Rails 5.2.3 Local DB: MySQL
​
* System dependencies
  - Install heroku CLI on your local computer
   https://devcenter.heroku.com/articles/heroku-cli
​
* Configuration
   - Setup Telegram on your mobile phone or laptop. Create Telegram account,
   create telegram channel for flats.
   - Create account on https://www.heroku.com/
​
* Database creation (if you want to play on your local machine)
   - ```rake db:create db:migrate```
​
* Services

  Application has 3 main files:

  populate_flats.rake (Fill DB with info about currently available flats on the website)

  fetch_new_flats.rake (You can fetch new flats manually)

  task_scheduler.rb (Will take care about automatic fetching)

  You have to change URLs in this files with your URLs and chat_id. Also set BOT_TOKEN to the ENV

  ENV['BOT_TOKEN'] you can get using this manual https://core.telegram.org/bots

   Don't forget to put it here:
   https://dashboard.heroku.com/apps/YOUR_APP_NAME/settings

   Create your own chat in the Telegram (if you still did not do it) and change chat_id in files: fetch_new_flats.rake:22 and task_scheduler.rb:26
* Deployment instructions
​
  You can find it in the Internet (How deploy to Heroku)

  ```git push -u heroku master```

  After FIRST deploy immediately run from console (you have 2 minutes after deploy to run it)

  ```heroku run rake populate_flats```

  Or you will get 20 messages in you Telegram chanel (chat) with information about flat from the last page of 'immoscout'

  Useful commands

  ```heroku logs -t```
* Free heroku app goes to sleep after 30 minutes of inactivity. To prevent it use monitoring services. I use this free service - https://uptimerobot.com/
​
Collapse







Message alexandra.khomich


