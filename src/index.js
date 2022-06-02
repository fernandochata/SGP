import app from './app.js';
import { connectToDB } from '../src/database/database.js'

function main() {
    connectToDB();

    app.listen(4000, () => {
        console.log('Server is running on port 4000');
    });

}

main();