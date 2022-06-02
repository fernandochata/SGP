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
 * perfil               (perfiles: administrador, funcionario, jefe interno, jefe Superior, alcalde)
 * cargo                (cargo del usuario dentro de la empresa)
 * departamento         (departamento al que pertenece el usuario)
 */

import mongoose from 'mongoose';

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
        type: Array,
        default: []
    },
    correo: {
        type: String,
        required: true,
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
        default: Date.now
    },
    perfil: {
        type: String,
        required: true
    },
    cargo: {
        type: String,
        required: true
    },
    departamento: {
        type: String,
        required: true
    }
},{
    timestamps: true,
    versionKey: false
});


export default mongoose.model('User', userSchema);