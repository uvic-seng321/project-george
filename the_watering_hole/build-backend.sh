#!/bin/bash

# Stop the container if it is already running
if [ "$(docker ps -a -q -f name=the_watering_hole_flask)" ]; then
    docker stop the_watering_hole_flask
    docker rm the_watering_hole_flask
fi

# Build the flask backend and run it on port 3434 (port used for testing for now)
docker image build -t the_watering_hole_flask -f Dockerfile.flask .
docker run -p 5000:5000 -d --name the_watering_hole_flask the_watering_hole_flask

