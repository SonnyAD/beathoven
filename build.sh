#!/bin/bash

tools/7za a -tzip Beathoven.zip assets/ gameobjects/ pages/ responsive/ utils/ fonts.lua main.lua -mx0
mv Beathoven.zip Beathoven.love

love.js -t Beathoven -c Beathoven.love game 

ssh utile rm -rf /usr/share/nginx/html/beathoven/*

scp -r game/* utile:/usr/share/nginx/html/beathoven/