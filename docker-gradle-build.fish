#!/usr/bin/env fish

docker run --rm -v "$PWD":/home/gradle/project \
                -w /home/gradle/project \
                gradle:5.1.1-jdk11 \
                gradle clean build
