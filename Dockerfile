FROM octohost/middleman-nginx

WORKDIR /srv/www

ADD . /srv/www

EXPOSE 80

# Install the necessary gems
ADD Gemfile /srv/www/Gemfile
ADD Gemfile.lock /srv/www/Gemfile.lock
RUN bundle install
RUN bundle exec middleman build

CMD nginx
