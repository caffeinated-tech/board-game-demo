
# Install some libraries and tools

## install RVM
\curl -sSL https://get.rvm.io | bash

## Install some libs for rails & ruby
sudo apt-get install gcc
sudo apt-get install ruby-dev
sudo apt-get install zlib1g-dev

## install newest node js version
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs

## Install the DB
sudo apt-get install mongodb

## Clone the code
git clone git@github.com:caffeinated-tech/board-game-demo.git

# inside the repo

## install node modules
cd front_end
sudo npm install gulp-cli -g
npm install

## Build
gulp watch

# isntall rails libraries
cd back_end
bundle install

# run rails
rails s -b 0.0.0.0 -p 3000