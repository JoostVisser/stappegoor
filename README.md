Website Stappegoor
======

Welcome to the code of the website of the horeca of [Stappegoor](http://horecatilburg.nl "Stappegoor")

The server is hosted on a Ruby on Rails framework. 
The server can be executed with the following command: 
```bash
rvmsudo bundle exec passenger start
```

Restarting the server can be done as follows:
```bash
cd /var/www/myapp/code
git pull
bundle install --deployment --without development test
bundle exec rake assets:precompile db:migrate RAILS_ENV=production
passenger-config restart-app $(pwd)
```

Remember to create a new application.yml in the config folder if you pull & deploy this on a new server.