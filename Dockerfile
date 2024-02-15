FROM ruby:3.3-bullseye

RUN apt-get update && \
    apt-get install -y --no-install-recommends fontforge sfnt2woff-zopfli woff2 && \
    apt-get clean && \
    ln -s /usr/bin/sfnt2woff-zopfli /usr/local/bin/sfnt2woff # fontcustom calls `sfnt2woff-zopfil` without suffix

COPY . /app/fontcustom
RUN bundle config set without development && bundle install --gemfile /app/fontcustom/Gemfile

WORKDIR /data

ENTRYPOINT ["bundle", "exec", "--gemfile", "/app/fontcustom/Gemfile", "fontcustom"]
