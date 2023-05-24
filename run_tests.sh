#!/bin/bash

[[ -z "$LIBSQL_URL" ]] && exit 1

rm -rf atlas || exit 2

git clone --no-tags --single-branch --branch libsql https://github.com/haaawk/atlas.git || exit 3

cd atlas

git apply ../0001-Add-libsql-driver-to-integration-tests.patch || exit 4
git apply ../0001-Clean-up-TestSQLite_Sanity-test.patch || exit 5
git apply ../0001-Make-it-possible-to-run-integration-tests-for-Libsql.patch || exit 6
git apply ../0001-Hide-Libsql-internal-tables.patch || exit 7

cd internal/integration

go test -count=1 -p=1 -parallel=1 -run='TestSQLite_' ./... || exit 8

cd ../../..

rm -rf atlas || exit 9
