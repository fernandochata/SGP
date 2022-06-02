import User from '../models/user.model.js'

/**
 * * Retorna un usuario segun su rut
 * @param {Request} req 
 * @param {Response} res status  
 * @returns {Promise<void>}
 * @throws {status} 500 - Internal Server Error
 * @throws {status} 204 - No Content
 */
export const getUser = async (req, res) => {
    try {
        const user = await User.findOne({ rut: req.params.rut })
        if (!user) return res.status(204).send('User not found')
        res.status(200).send(user)
    } catch (error) {
        res.status(500).send(error.message)
    }
};

/**
 * * Retorna todos los usuarios
 * @param {Response} res - archivo JSON con una lista de usuarios
 * @returns {Promise<void>}
 * @throws {status} 500 - Internal Server Error
 * @throws {status} 204 - No Content
 */
export const getUsers = async (req, res) => {
    try {
        const users = await User.find();
        if (!users) return res.status(204).send('Users not found')
        res.json(users)
    } catch (error) {
        console.log(error);
    }
};

/**
 * * Crea un usuario
 * @param {Request} req 
 * @param {Response} res 
 * @returns {Promise<void>}
 * @throws {status} 500 - Internal Server Error
 * @throws {status} 204 - No Content
 */
export const createUser = async (req, res) => {
    try {
        const newUser = await User.create(req.body);
        if (!newUser) return res.status(204).send('User not created');
        res.json(newUser);
    } catch (error) {
        res.status(500).send(error.message);
    }
};

/**
 * 
 * @param {Request} req 
 * @param {Response} res 
 * @returns {Promise<void>}
 * @throws {status} 500 - Internal Server Error
 * @throws {status} 204 - No Content
 */
export const updateUser = async (req, res) => {
    try {
        const user = await User.findByIdAndUpdate(req.params.id, req.body, {new: true});
        if (!user) return res.status(204).send('User not found');
        res.status(200).json(user);
    } catch (error) {
        res.status(500).send(error.message)
    }

};

/**
 * * Elimina un usuario segun su rut
 * @param {Request} req 
 * @param {Response} res 
 * @returns {Promise<void>}
 * @throws {status} 500 - Internal Server Error
 * @throws {status} 204 - No Content
 */
export const deleteUser = async (req, res) => {
    try {
        const user = await User.findByIdAndRemove(
            await User.findOne({ rut: req.params.rut }).then(user => user._id)
        );
        //const user = await User.findByIdAndRemove(await getUserIdByRut(req.params.rut));
        res.json(user);
    } catch (error) {
        res.status(500).send(error.message);
    }
};


async function getUserIdByRut(rut) {
    return await User.findOne({ rut: rut }).then(user => user._id);
}