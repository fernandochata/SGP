/**
 * codigo
 * fechaCreacion
 * fechaInicio
 * fechaFin
 * dias
 * observaciones
 * rutUsuario
 * resolucion
 * docAdjunto
 * estado
 * tipo
 * motivo
 * 
 */

import mongoose from 'mongoose';

const licenceSchema = new mongoose.Schema({
    codigo: {
        type: String,
        required: true,
        unique: true,
        trim: true
    },
    fechaCreacion: {
        type: Date,
        required: true,
        default: Date.now
    },
    fechaInicio: {
        type: Date,
        required: true,
        default: Date.now
    },
    fechaFin: {
        type: Date,
        required: true,
        default: Date.now
    },
    dias: {
        type: Number,
        required: true,
        default: 0
    },
    observaciones: {
        type: String
    },
    rutUsuario: {
        type: String,
        required: true
    },
    resolucion: {
        type: String,
        required: true
    },
    docAdjunto: {
        type: String
    },
    estado: {
        type: String,
        required: true
    },
    tipo: {
        type: String,
        required: true
    },
    motivo: {
        type: String
    }
},{
    timestamps: true,
    versionKey: false,
});

export default mongoose.model('Licence', licenceSchema)