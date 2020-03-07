#!/bin/sh

cat <<EOF> "${BOX_FILENAME}.metadata.json"
{
  "name": "${BOX_NAME}",
  "description": "This box contains Debian Stretch ${BOX_VERSION}",
  "versions": [
    {
      "version": "${BOX_VERSION}",
      "providers": [
        {
          "name": "virtualbox",
          "url": "file://$(pwd)/${BOX_FILENAME}.box"
        }
      ]
    }
  ]
}

EOF
