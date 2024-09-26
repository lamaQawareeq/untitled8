import { initializeApp } from 'firebase/app';
import "firebase/auth";
import "firebase/database";
import "firebase/storage";

const firebaseConfig = {
    apiKey: "AIzaSyBN8Tf9fj0nSji1P9i4-KWrUF59w9gJIoY",
    authDomain: "flluter-clone.firebaseapp.com",
    projectId: "flluter-clone",
    storageBucket: "flluter-clone.appspot.com",
    messagingSenderId: "918347899919",
    appId: "1:918347899919:web:6ddba2677251c222e92f7a",
    measurementId: "G-9BWVZMGVS9"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
export default app; // تصدير التطبيق بدلاً من firebase
