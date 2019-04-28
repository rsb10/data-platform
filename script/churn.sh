#!/usr/bin/env bash

# The script churns aka install | manage all applications
# for the local dataplatform setup

source ./config
source ./operations.sh

usage() {
  echo "usage: churn --app [spark|flink|kafka|zookeeper|all] --action [intall|start|stop|restart]"
}

parse_args() {
  while [[ $# -gt 0 ]]; do

    case $1 in
      --app)      shift
                  app=$1
                  ;;
      --action)   shift
                  action=$1
                  ;;
      *)          usage
                  ;;
    esac
    shift

  done
}

print_config() {
  echo
  echo "########################################## Loading Config #############################################"
  echo
  cat ./config
  echo
  echo
  echo "#######################################################################################################"
  echo
}

main() {
  parse_args $@

  supported_apps=("spark" "flink" "kafka" "zookeeper")
  supported_actions=("install" "delete" "start" "stop" "restart")

  if [[ " ${supported_apps[*]} " == *"$app"*] && [ " ${supported_actions[*]} " == *"$action"* ]];
  then
    create_dataplatform $download_dir

    case $action in
      install) install $app
               ;;
      start)   start $app
               ;;
      stop)    stop $app
               ;;
      restart) restart $app
               ;;
    esac
  else
    usage
    exit 1
  fi


}  

main $@
