---
title: Deploying Middleman to GitHub Pages
date: 2014-06-06 08:15 UTC
tags: middleman, github-pages
---

Today I began using [GitHub Pages](https://pages.github.com/) to host my blog. It is created using Middleman -- a static site generator. I followed the guide provided by GitHub but it left out a few details so here is a tutorial on how to setup GitHub Pages, a custom domain, and Middleman deploys.

### Setting up GitHub Pages

1. Create a repository using the format requested by GitHub where `username` is your GitHub username.
    ```
    username.github.io
    ```
2. Create a branch called `source` and place your source files there. GitHub Pages requires that your static files be placed in `master`.
    ```
    git checkout -b source
    ```

### Setup custom domain with GitHub Pages

As outlined by the [GitHub documentation](https://help.github.com/articles/setting-up-a-custom-domain-with-github-pages)

1. Create a `CNAME` file with your custom domain in the source directory of your source branch.
    ```
    blog.justinleveck.com
    ```
    I decided to go with using a <b>[custom subdomain](https://help.github.com/articles/setting-up-a-custom-domain-with-github-pages)</b> for the various reasons provided by GitHub which include access to their CDN, being immune to changes in IP addresses for GitHub, and faster load times.

2. Configure a CNAME record with your DNS provider.
3. Disable Jekyl processing by creating `.nojekyll` in the source directory of your source branch.

### Setup Middleman Deploys

1. Add [middleman-deploy](https://github.com/karlfreeman/middleman-deploy) to your Gemfile
    ```
    gem 'middleman-deploy'
    ```
2. Run `bundle install`
3. Activate the extension in `config.rb`
    ```ruby
    activate :deploy do |deploy|
      deploy.method = :git
      deploy.branch = 'master'
    end
    ```
4. To deploy to GitHub Pages, from the `source` branch run
    ```
    middleman build
    middleman deploy
    ```

    The statically generated files will be pushed to your remote master and live within a few minutes.
