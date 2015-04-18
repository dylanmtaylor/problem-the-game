#!/bin/bash
rm game.love
zip -r game.zip . -x loveFiles/*
mv game.zip game.love

