#!/usr/bin/env sh

# all variables are defined in gitlab-ci.yml
newman run "$POSTMAN_API_URL/collections/$POSTMAN_COLLECTION_UUID?apikey=$POSTMAN_API_KEY" \
    -e "$POSTMAN_API_URL/environments/$POSTMAN_ENV_UUID?apikey=$POSTMAN_API_KEY"