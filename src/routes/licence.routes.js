import { Router } from 'express';

import { getLicence,getLicences, createLicence, updateLicence,deleteLicence} from '../controllers/licence.controllers.js';

const router = Router();

router.get('/:id', getLicence)

router.get('/', getLicences)

router.post('/', createLicence)

router.put('/:id', updateLicence)

router.delete('/:id', deleteLicence)

export default router;