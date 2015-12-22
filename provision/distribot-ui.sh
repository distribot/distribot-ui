#!/bin/bash

set -e

setup_dependencies() {
  sudo apt-get -y update
  sudo apt-get -y autoremove
  sudo apt-get install -y \
    ruby2.0 \
    ruby2.0-dev \
    build-essential \
    git \
    wget \
    vim \
    librabbitmq-dev \
    psmisc \
    curl \
    libcurl4-gnutls-dev \
    python

  sudo ln -sf /usr/bin/ruby2.0 /usr/bin/ruby && sudo ln -sf /usr/bin/gem2.0 /usr/bin/gem

  if ! gem list | grep bundler; then
    sudo gem install bundler --no-ri --no-rdoc
  fi

  # Don't fail because we haven't added github.com's ssh key to our known_hosts:
  cat <<EOF | sudo tee -a /etc/ssh/ssh_config > /dev/null
Host github.com
    StrictHostKeyChecking no
EOF
}

setup_dependencies

while ! ( echo -e "443\n6379\n5672" | xargs -i nc -w 1 -zv $INFRA_HOST {} ) ; do
  echo "Waiting for infra to come up..."
  sleep 5
done

cd /var/www/distribot-ui
bundle

echo '
########  ####  ######  ######## ########  #### ########   #######  ########
##     ##  ##  ##    ##    ##    ##     ##  ##  ##     ## ##     ##    ##
##     ##  ##  ##          ##    ##     ##  ##  ##     ## ##     ##    ##
##     ##  ##   ######     ##    ########   ##  ########  ##     ##    ##
##     ##  ##        ##    ##    ##   ##    ##  ##     ## ##     ##    ##
##     ##  ##  ##    ##    ##    ##    ##   ##  ##     ## ##     ##    ##
########  ####  ######     ##    ##     ## #### ########   #######     ##
'
