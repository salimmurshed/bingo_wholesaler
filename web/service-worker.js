import firebase from 'firebase/app';
import 'firebase/messaging';

// See: https://github.com/microsoft/TypeScript/issues/14877
/** @type {ServiceWorkerGlobalScope} */
let self;

function initInSw() {
  // [START messaging_init_in_sw]
  // Give the service worker access to Firebase Messaging.
  // Note that you can only use Firebase Messaging here. Other Firebase libraries
  // are not available in the service worker.
  importScripts('https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js');
  importScripts('https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js');

  // Initialize the Firebase app in the service worker by passing in
  // your app's Firebase config object.
  // https://firebase.google.com/docs/web/setup#config-object
  firebase.initializeApp({
      apiKey: "AIzaSyBfdCWI9ioYe8L7z8QQibiKEg5a2Spjp_k",
      authDomain: "bingo01.firebaseapp.com",
      projectId: "bingo01",
      storageBucket: "bingo01.appspot.com",
      messagingSenderId: "119212193003",
      appId: "1:119212193003:web:939a6a2129fa50a2d2baae",
      measurementId: "G-8H58NJ86GP"

  });

  // Retrieve an instance of Firebase Messaging so that it can handle background
  // messages.
  const messaging = firebase.messaging();
  // [END messaging_init_in_sw]
}

function onBackgroundMessage() {
  const messaging = firebase.messaging();

  // [START messaging_on_background_message]
  messaging.onBackgroundMessage((payload) => {
    console.log(
      '[firebase-messaging-sw.js] Received background message ',
      payload
    );
    // Customize notification here
    const notificationTitle = 'Background Message Title';
    const notificationOptions = {
      body: 'Background Message body.',
      icon: '/firebase-logo.png'
    };

    self.registration.showNotification(notificationTitle, notificationOptions);
  });
  // [END messaging_on_background_message]
}