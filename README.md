Requirement:

- Ruby = 2.3.3
- MySQL >= 5.6


To start the application, follow the steps:
0. clone repo and change directory to root for this app
1. run 'bundler install'
2. change user and password to mysql server in config/database.yml
3. run 'rake db:create db:migrate'
4. run 'rails s'
5. get to 'http://127.0.0.1:3000/' in browser

profit!