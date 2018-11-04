#!/usr/bin/env bash

#
# This scripts accept the environment file name used as parameter
#

# make available environment variables
export $(grep -v '^#' $1 | xargs)
# dump files
[ -d ${DUMP_DIR} ] || mkdir -p ${DUMP_DIR}
[ -f ${DUMP_DIR}/.get-todos.body ] || (touch ${DUMP_DIR}/.get-todos.body && chmod 775 ${DUMP_DIR}/.get-todos.body)
[ -f ${DUMP_DIR}/.get-todos.headers ] || (touch ${DUMP_DIR}/.get-todos.headers && chmod 775 ${DUMP_DIR}/.get-todos.headers)

# make request saving response headers and body
curl -sD ${DUMP_DIR}/.get-todos.headers  -o ${DUMP_DIR}/.get-todos.body \
    --request GET \
    --url "http://${HOST}:${PORT}/todos"

# After here, dumped files can be analyzed
# and assertions can be made for checking
# desired headers, response status and body.

# validate against its schema
ajv validate -s get-todos.schema.json -d ${DUMP_DIR}/.get-todos.body >/dev/null

# test response status
read PROTO STATUS MSG <<< $(head -n 1 ${DUMP_DIR}/.get-todos.headers)
[ $STATUS == 200 ] || (echo "Response status code is not 200" && exit 1)

# test header value

# https://stackoverflow.com/questions/24943170/how-to-parse-http-headers-using-bash#answer-24944588
shopt -s extglob # Required to trim whitespace; see below

IFS=':' read KEY VALUE <<< $(cat ${DUMP_DIR}/.get-todos.headers | grep -Fe "Content-Type:")
# trim whitespace in "VALUE"
VALUE=${VALUE##+([[:space:]])}; VALUE=${VALUE%%+([[:space:]])}
[ "$VALUE" == "application/json; charset=utf-8" ] || (echo "Wrong Content-Type" && exit 1)