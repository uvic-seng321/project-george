[![CI](https://github.com/uvic-seng321/project-george/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/uvic-seng321/project-george/actions/workflows/ci.yml)

# The Watering Hole

Welcome to The Watering Hole! This is a social media application for posting pictures of cool animals.

## Finding your way around the repo

Frontend code is located here:

https://github.com/uvic-seng321/project-george/tree/main/the_watering_hole/lib

Backend code is located here:

https://github.com/uvic-seng321/project-george/blob/ba4e501fe370756d36f9fbda4943a992f4316c32/the_watering_hole/api/posts.py

Tests are demonstrated here:

TODO TEST VIDEO

## Running the application

This is a mobile application, and thus a mobile device or emulator is required to run this application. It will be difficult to run this application locally, as it involves installing lots of software. If the steps for running the application are too difficult, we have provided [a demo of the project](
https://drive.google.com/file/d/1cukv0qmRoNZ2XMyCB1G1QqzbzaIx5Nht/view?usp=sharing). This demo shows all currently implemented functionality of the application.

### Setting up the project

In order to locally run the project, you must have a local clone of this repository. Once you have this, open the project up in Android Studio, XCode, or Visual Studio Code. Depending on your local environment/OS (Linux, Mac, Windows), the install for a Flutter development environment will be very different, so I suggest looking it up.

### Emulating

Once you have Flutter downloaded and your IDE of choice working, you need to connect a mobile device. You may use XCode to emulate a phone running iOS, Android Studio to emulate an Android phone, or you may use any IDE to run the app on your own phone. 

### Running

You will need to select the device you're using in your IDE. As well, you will likely be asked to pick what file to run. The main file is `nain.dart`. You will then need to hit the `run` or `debug` button in your IDE. This will spin up an instance of the application on your mobile device.

### Making your way around the app

From here, you may following along with [the demo](
https://drive.google.com/file/d/1cukv0qmRoNZ2XMyCB1G1QqzbzaIx5Nht/view?usp=sharing) on your mobile device to see how to use the app. It should be quite straightforward, as there is a very limited functionality with only the MVP implemented.

### Running tests

TODO talk about locally running tests

# Links to Documentation

[Data Flow Diagram](https://github.com/uvic-seng321/project-george/blob/5bb3e2ae5e0cb7c4bcf7e14bb03f7e6555b48b20/DFD.jpeg)

[Table Design](https://github.com/uvic-seng321/project-george/blob/5bb3e2ae5e0cb7c4bcf7e14bb03f7e6555b48b20/SQL%20Documentation/Table%20Design.txt)

[Stored Procedure Design](https://github.com/uvic-seng321/project-george/blob/5bb3e2ae5e0cb7c4bcf7e14bb03f7e6555b48b20/SQL%20Documentation/SP%20Design.txt)

[SQL code for `uploadPost`](https://github.com/uvic-seng321/project-george/blob/5bb3e2ae5e0cb7c4bcf7e14bb03f7e6555b48b20/SQL%20Documentation/uploadPost.txt)

[SQL code for `getPost`](https://github.com/uvic-seng321/project-george/blob/5bb3e2ae5e0cb7c4bcf7e14bb03f7e6555b48b20/SQL%20Documentation/getPosts.txt)
