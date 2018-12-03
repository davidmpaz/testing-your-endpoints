#!/usr/bin/env bash


docker run --rm --net test byrnedo/alpine-curl \
    --form "project=@$CI_PROJECT_DIR/soapui/JSONPlaceholder-soapui-project.xml" \
    --form "properties=@$CI_PROJECT_DIR/soapui/test.properties" \
    http://$SOAPUI_HOST_NAME:3000
exit