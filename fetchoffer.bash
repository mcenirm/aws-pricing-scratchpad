#!/bin/bash

set -e
set -u

start_site='https://pricing.us-east-1.amazonaws.com'
start_path='/offers/v1.0/aws/index.json'
start=${start_site}${start_path}
names=(
    AmazonS3
    IngestionServiceSnowball
    SnowballExtraDays
)


curl -s -R -z start.json -o start.json "$start"

for name in "${names[@]}" ; do
  filter=".offers.${name}.currentVersionUrl"
  echo == "$name"
  offer_url=$( jq -r -S "$filter" < start.json )
  if [ "$offer_url" = "${offer_url#https://}" ] ; then
    offer_url=${start_site}${offer_url}
  fi
  for ext in json csv ; do
    offer_file=${name}.${ext}
    (set -x ; curl -s -R -z "$offer_file" -o "$offer_file" "${offer_url%.json}.${ext}" )
  done
done
