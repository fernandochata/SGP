import { Router } from 'express';

import { getUser, getUsers, createUser, updateUser, deleteUser} from '../controllers/user.controllers.js';
const router = Router();

router.get('/:rut', getUser)

router.get('/', getUsers)

router.post('/', createUser)

router.put('/:rut', updateUser)

router.delete('/:rut', deleteUser)

export default router;