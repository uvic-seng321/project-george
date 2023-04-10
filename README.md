[![CI](https://github.com/uvic-seng321/project-george/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/uvic-seng321/project-george/actions/workflows/ci.yml)

# The Watering Hole

Welcome to The Watering Hole! This is a social media application for posting pictures of cool animals.

## Finding your way around the repo

### Frontend code is located here:

https://github.com/uvic-seng321/project-george/tree/main/the_watering_hole/lib

### Backend code is located here:

https://github.com/uvic-seng321/project-george/tree/main/the_watering_hole/api

### A demo of the project is given here:

https://drive.google.com/file/d/1cukv0qmRoNZ2XMyCB1G1QqzbzaIx5Nht/view?usp=sharing

### Tests are located here:

https://github.com/uvic-seng321/project-george/tree/main/the_watering_hole/test_driver

### Tests are demonstrated in this video:

Note that the visualization of the test isn't very meaningful - you can just see the automated test driver navigating across the app. If you would like, you can match up the actions of the test driver with Appendix A in the report. Appendix A shows exactly what the test driver is doing at each step in chronological order. We recommend you follow along with Appendix A, reading each step and then pausing the video at notable points to see a description of what is occurring in the video. 

https://drive.google.com/file/d/106LxHjkCByt3UU1Tqo-j92Haji-VlwD3/view?usp=share_link

## Running the application

This is a mobile application, and thus a mobile device or emulator is required to run this application. It will be difficult to run this application locally, as it involves installing lots of software. If the steps for running the application are too difficult, we have provided [a demo of the project](https://drive.google.com/file/d/1cukv0qmRoNZ2XMyCB1G1QqzbzaIx5Nht/view?usp=sharing). This demo shows all currently implemented functionality of the application. 

One important side note is that the frontend of the application relies heavily on the backend. When you upload a post, a call to the backend is made, resulting in data being stored in a database and images being stored on a server PC. When you view the "image feed", you are making constant GET requests to the backend to receive image data based on your filters with the search bar. Because the backend is not constantly running, you will not be able to test these main features. Thus, it's recommended to simply watch the demo of the application to understand the implemented functionality.

### Setting up the project

In order to locally run the project, you must have a local clone of this repository. Once you have this, open the project up in Android Studio, XCode, or Visual Studio Code. Depending on your local environment/OS (Linux, Mac, Windows), the install for a Flutter development environment will be very different, so I suggest looking it up.

### Emulating

Once you have Flutter downloaded and your IDE of choice working, you need to connect a mobile device. You may use XCode to emulate a phone running iOS, Android Studio to emulate an Android phone, or you may use any IDE to run the app on your own phone. 

### Running

You will need to select the device you're using in your IDE. As well, you will likely be asked to pick what file to run. The main file is `nain.dart`. You will then need to hit the `run` or `debug` button in your IDE. This will spin up an instance of the application on your mobile device.

### Making your way around the app

From here, you may following along with [the demo also linked above](https://drive.google.com/file/d/1cukv0qmRoNZ2XMyCB1G1QqzbzaIx5Nht/view?usp=sharing) on your mobile device to see how to use the app. It should be quite straightforward, as there is a very limited functionality with only the MVP implemented.

### Running tests

If you would like to locally run tests, then all you have to do is have a mobile device emulator running and then run 

```
flutter drive --target=test_driver/app.dart
```

# Links to Documentation

[Data Flow Diagram](https://github.com/uvic-seng321/project-george/blob/5bb3e2ae5e0cb7c4bcf7e14bb03f7e6555b48b20/DFD.jpeg)

[Table Design](https://github.com/uvic-seng321/project-george/blob/5bb3e2ae5e0cb7c4bcf7e14bb03f7e6555b48b20/SQL%20Documentation/Table%20Design.txt)

[Stored Procedure Design](https://github.com/uvic-seng321/project-george/blob/5bb3e2ae5e0cb7c4bcf7e14bb03f7e6555b48b20/SQL%20Documentation/SP%20Design.txt)

[SQL code for `uploadPost`](https://github.com/uvic-seng321/project-george/blob/5bb3e2ae5e0cb7c4bcf7e14bb03f7e6555b48b20/SQL%20Documentation/uploadPost.txt)

[SQL code for `getPost`](https://github.com/uvic-seng321/project-george/blob/5bb3e2ae5e0cb7c4bcf7e14bb03f7e6555b48b20/SQL%20Documentation/getPosts.txt)
