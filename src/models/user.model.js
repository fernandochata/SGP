/**
 * rut                  (rut del usuario)
 * clave                (clave del usuario)
 * nombre               (nombre completo del usuario)
 * direccion            (direccion del usuario)
 * telefono             (telefono del usuario)
 * correo               (correo del usuario)
 * diasLegales          (dias de permisos legales de usuario, según las reglas del negocio)
 * diasAdministrativos  (dias de permisos administrativos de usuario, según las reglas del negocio)
 * fechaContrato        (fecha de contrato del usuario)
 * perfil               (perfiles: administrador, emlpeado, jefe interno, jefe Superior)
 * cargo                (cargo del usuario dentro de la empresa)
 * departamento         (departamento al que pertenece el usuario)
 */

import mongoose from 'mongoose';

/**
 * 
 */

const userSchema = new mongoose.Schema({
    rut: {
        type: String,
        required: true,
        unique: true,
        trim: true
    },
    clave: {
        type: String,
        required: true
    },
    nombre: {
        type: String,
        required: true,
        trim: true
    },
    direccion: {
        type: String,
        required: true,
        trim: true
    },
    telefono: { 
            celular: {
                type: Number,
                default: 0
            },
            fijo: {
                type: Number,
                default: 0
            }
    },
    correo: {
        type: String,
        required: true,
        lowercase: true,
        minlength: 5,
        maxlength: 50,
        trim: true
    },
    diasLegales: {
        type: Number,
        default: 0
    },
    diasAdministrativos: {
        type: Number,
        default: 0
    },
    fechaContrato: {
        type: Date,
        required: true,
        inmutable: true,
        default: () => Date.now()
    },
    perfil: {
        type: String,
        required: true,
        validate: {
            validator: (value) => {
                return ['administrador', 'empleado', 'jefe interno', 'jefe superior'].includes(value);
            },
            message: props => ` \"${props.value}\" no es un valor permitido para el perfil`
        }
    },
    cargo: {
        type: String,
        required: true,
        trim: true
    },
    departamento: {
        type: String,
        required: true,
        trim: true
    }
});

const User = mongoose.model('User', userSchema);

export default User;