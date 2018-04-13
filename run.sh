#!/usr/bin/env bash
set -eo pipefail

#echo "export path=$PATH:/usr/local/bin/">>~/.bashrc
#source ~/.bashrc

case $1 in
  start)
    # The '| cat' is to trick Node that this is an non-TTY terminal
    # then react-scripts wont clear the console.
    yarn start | cat
    ;;
  build)
    yarn build
    ;;
  test)
    yarn test $@
    ;;
  *)
    exec "$@"
    ;;
esac
