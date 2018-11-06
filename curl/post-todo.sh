#!/usr/bin/env bash

# make available environment variables
export $(grep -v '^#' $1 | xargs)

# dump files
[[ -d ${DUMP_DIR} ]] || mkdir -p ${DUMP_DIR}
[[ -f ${DUMP_DIR}/.get-todos.body ]] || (touch ${DUMP_DIR}/.get-todos.body && chmod 775 ${DUMP_DIR}/.get-todos.body)
[[ -f ${DUMP_DIR}/.get-todos.headers ]] || (touch ${DUMP_DIR}/.get-todos.headers && chmod 775 ${DUMP_DIR}/.get-todos.headers)

request='/carts/1/applyDiscount'

echo POST ${rootURL}${request}
curl -sD ${DUMP_DIR}/.post-todos.headers  -o ${DUMP_DIR}/.post-todos.body \
    -w "@curl-format" \
    --request POST \
    --header "Content-Type: application/json" \
    --url "http://${HOST}:${PORT}/todos" \
    --data @data/todo.json