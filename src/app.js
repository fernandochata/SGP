import express from 'express';
import cors from 'cors';

import userRoutes from './routes/user.routes.js';
import licenceRoutes from './routes/licence.routes.js';

const app = express();

/**
 * MIDDLEWARES
 */
app.use(cors());
app.use(express.json());


/**
 * ROUTES
 */
app.use('/api/v1/users', userRoutes);
app.use('/api/v1/licences', licenceRoutes);


export default app;