import User from '../models/user.model.js'

export const getUser = async (req, res) => {
    const user = await User.findById(req.params.id);
    res.json(user)
};

export const getUsers = async (req, res) => {
    try {
        const users = await User.find();
        res.json(users)
    } catch (error) {
        console.log(error);
    }
};

export const createUser = async (req, res) => {
    const newUser = await User.create(req.body);
    //const newUser = new User(req.body).save();
    res.json(newUser)
};

export const updateUser = async (req, res) => {
    const user = await User.findByIdAndUpdate(req.params.id, req.body, {new: true});
    res.json(user)

};

export const deleteUser = async (req, res) => {
    const user = await User.findByIdAndRemove(req.params.id);
    res.json(user);
};