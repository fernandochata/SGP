import Licence from '../models/licence.model.js'

export const getLicence = async (req, res) => {
    const licence = await Licence.find(req.params.id);
    res.json(licence)
};

export const getLicences = async (req, res) => {
    const licences = await Licence.find();
    res.json(licences)
};

export const createLicence = async (req, res) => {
    const newLicence = await Licence.create(req.body);
    //const newLicence = await User(req.body).save();
    res.json(newLicence)
};

export const updateLicence = async (req, res) => {
    const licence = await Licence.findByIdAndUpdate(req.params.id, req.body, {new: true});
    res.json(licence)

};

export const deleteLicence = async (req, res) => {
    const licence = await Licence.findByIdAndRemove(req.params.id);
    res.json(licence);
};