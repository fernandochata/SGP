import Licence from '../models/licence.model.js'

/**
 * * Retorna una licencia segun su id
 * @param {Request} req 
 * @param {Response} res 
 */
export const getLicence = async (req, res) => {
    try {
        const licence = await Licence.find(req.params.id);
        res.json(licence)
    } catch (error) {
        res.status(500).send(error.message)
    }
};

/**
 * * Retorna todas las licencias
 * @param {Request} req 
 * @param {Response} res 
 */
export const getLicences = async (req, res) => {
    try {
        const licences = await Licence.find();
        res.json(licences)
    } catch (error) {
        res.status(500).send(error.message)
    }
};

/**
 * * Crea una licencia
 * @param {Request} req 
 * @param {Response} res 
 */
export const createLicence = async (req, res) => {
    try {
        const newLicence = await Licence.create(req.body);
        res.json(newLicence)
    } catch (error) {
        res.status(500).send(error.message);
    }
};

/**
 * * Actualiza una licencia según su id
 * @param {Request} req 
 * @param {Response} res 
 */
export const updateLicence = async (req, res) => {
    try {
        const licence = await Licence.findByIdAndUpdate(req.params.id, req.body, {new: true});
        res.json(licence)
    } catch (error) {
        res.status(500).send(error.message)
    }

};

/**
 * * Elimina una licencia segun su id
 * @param {Request} req 
 * @param {Response} res 
 */
export const deleteLicence = async (req, res) => {
    try {
        const licence = await Licence.findByIdAndRemove(req.params.id);
        res.json(licence);
    } catch (error) {
        res.status(500).send(error.message);
    }
};