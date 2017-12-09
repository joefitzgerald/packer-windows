#!/bin/bash

for template in $(ls -1 *.json); do
  echo $template
  packer fix $template >/tmp/$$.json
  mv /tmp/$$.json $template
done
