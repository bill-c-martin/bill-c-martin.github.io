#!/bin/sh

# Install the version of Bundler.
if [ -f Gemfile.lock ] && grep "BUNDLED WITH" Gemfile.lock > /dev/null; then
    cat Gemfile.lock | tail -n 2 | grep -C2 "BUNDLED WITH" | tail -n 1 | xargs sudo gem install bundler -v
fi

# If there's a Gemfile, then run `bundle install`
# It's assumed that the Gemfile will install Jekyll too
if [ -f Gemfile ]; then
    bundle install
fi

yellow=$(tput setaf 3)
normal=$(tput sgr0)

printf "\n"
printf "%40s\n" "${yellow}********************************************************************************"
printf "%40s\n" "Don't forget to start the server after pressing any key to continue:"
printf "%40s\n" "bundle exec jekyll serve"
printf "%40s\n" "********************************************************************************${normal}"
printf "\n"