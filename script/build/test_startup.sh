#!/bin/bash
RAILS_ENV=$1
APP_PORT=$2
WS_PORT=$3

rails r "Setting.set('developer_mode', true)"
rails r "Setting.set('websocket_port', '#{WS_PORT}')"

pumactl start --pidfile tmp/pids/puma.pid -d -p $APP_PORT -e $RAILS_ENV
script/websocket-server.rb start -d -p $WS_PORT
script/scheduler.rb start