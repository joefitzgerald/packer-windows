#!/bin/bash

for template in $(ls -1 *.json); do
  echo $template
  packer fix $template >/tmp/$$.json
  if [ $? -ne 0 ]; then
    cat /tmp/$$.json
    exit 1
  fi
  mv /tmp/$$.json $template
done
