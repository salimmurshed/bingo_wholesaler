importScripts("https://www.gstatic.com/firebasejs/7.5.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.5.0/firebase-messaging.js");
firebase.initializeApp({
      apiKey: "AIzaSyBfdCWI9ioYe8L7z8QQibiKEg5a2Spjp_k",
      authDomain: "bingo01.firebaseapp.com",
      projectId: "bingo01",
      storageBucket: "bingo01.appspot.com",
      messagingSenderId: "119212193003",
      appId: "1:119212193003:web:939a6a2129fa50a2d2baae",
      measurementId: "G-8H58NJ86GP"
});
const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});