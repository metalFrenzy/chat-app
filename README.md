# lonely Chat 

It is a chat application where users can signUp/Login and chat with other users. I developed this app using flutter and firebase.

## Main Functionalities of the app

* Users can signup/login 
* Users can send and receive messages 
* Apps sends a notification when a new message is received

## Main Packages and Widgets I have Used

I have used in this application Firebase and its service which are Firestore, firebase authentication, firebase storage, and Push notification. I have used cloud_firestore which is a Flutter plugin that helped me use the Cloud Firestore API to update, fetch, get, and post data to the Firestore database. I used the StreamBuilder widget as the Firestore returns streams of data so this widget helps me to listen to these streams and to build the widget tree. 

Furthermore, I used firebase_auth which is A Flutter plugin to use the Firebase Authentication API. This plugin does all the heavy lifting as behind the scenes it sends the request to store the data and the token as well as manages the token. Moreover, I used firebase_storage, and image_picker, these packages helped to access the device camera and let the user take a picture so they can set their own profile picture and the firebase storage package to use the Firebase Cloud Storage API so I can store the profile picture to the firebase storage.


