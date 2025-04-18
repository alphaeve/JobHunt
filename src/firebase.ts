// src/firebase.ts
import { initializeApp } from 'firebase/app';
import { getDatabase } from 'firebase/database';
import { getAnalytics } from "firebase/analytics";

const firebaseConfig = {
    apiKey: "AIzaSyAiHVnSY9nRdTcNVdaAmpjJlwgryEjWjQ0",
    authDomain: "jobhunt-45383.firebaseapp.com",
    projectId: "jobhunt-45383",
    storageBucket: "jobhunt-45383.firebasestorage.app",
    messagingSenderId: "359518541418",
    appId: "1:359518541418:web:3fc2229cce0cb2d3ad5c13",
    measurementId: "G-9C6PDKGVZN"
  };

const app = initializeApp(firebaseConfig);
export const database = getDatabase(app);
const analytics = getAnalytics(app);
