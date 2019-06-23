#!/bin/sh

FORMAT='{{range $key,$value := .Containers }}{{$value.Name|printf " %q "}}{{ end }}'
docker network inspect -f "$FORMAT" $1 | xargs
