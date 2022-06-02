import mongoose from 'mongoose';

const MONGO_URI = 'mongodb://localhost:27017/SGP'

export function connectToDB() {
    try {
        mongoose.connect(MONGO_URI);
        console.log('Connected to DB');
    } catch (error) {
        console.log(error);
    }
}