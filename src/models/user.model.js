import mongoose from 'mongoose';

/**
 * * Variable empleado
 * todo: validar modulo11 del rut ingresado
 * todo: validar ingreso de letras y espacio en el nombre (a-z A-Z y espacio, tildes Ñ)(primera letra en mayuscula)
 * todo: validar ingreso de letras en los apellidos (a-z A-Z tildes Ñ)(primera letra en mayuscula)
 * todo: ocultar la contraseña 
 * @param {String} rut rut del usuario, formato: 12345678-9
 * @param {String} clave clave del usuario
 * @param {String} nombreCompleto nombre completo del usuario, formato: nombres apellidoPaterno apellidoMaterno
 * @param {String} direccion direccion del usuario
 * @param {Object} telefono telefono del usuario, formato {celular: '123456789', fijo: '123456789'} 
 * @param {String} correo correo del usuario, formato: me@mail.com
 * @param {Number} diasLegales dias de permisos legales de usuario, según las reglas del negocio
 * @param {Number} diasAdministrativos dias de permisos administrativos de usuario, según las reglas del negocio
 * @param {Date} fechaContrato fecha de contrato del usuario
 * @param {String} perfil perfiles: administrador, empleado, jefe interno, jefe superior
 * @param {String} cargo cargo del usuario dentro de la empresa
 * @param {String} departamento departamento al que pertenece el usuario
 * @param {String} estado estado del usuario
 * 
 */
const empleado = {
    rut: {
        type: String,
        required: true,
        unique: true,
        trim: true,
        inmutable: true,
        minlength: 9,
        maxlength: 10,
        validate: {
            validator: function (value) {
                return /^[0-9]{1,2}[0-9]{3}[0-9]{3}[0-9]{2}[0-9]{2}$/.test(value);
            },
            message: props => ` \"${props.value}\" formato de rut incorrecto`
        }
    },
    clave: {
        type: String,
        required: true
    },
    nombreCompleto: {
        nombres: {
            type: String,
            required: true,
            trim: true,
            maxlength: 30
        },
        apellidoPaterno: {
            type: String,
            required: true,
            trim: true,
            maxlength: 15
        },
        apellidoMaterno: {
            type: String,
            trim: true,
            maxlength: 15
        }
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
        trim: true,
        unique: true,
        validate: {
            validator: function(email) {
                return /^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/.test(email);
            },
            message: props => ` \"${props.value}\" formato de correo incorrecto`
        }
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
        default: () => Date.now()
    },
    perfil: {
        type: String,
        required: true,
        validate: {
            validator: (perfil) => {
                return ['administrador', 'empleado', 'jefe interno', 'jefe superior'].includes(perfil);
            },
            message: props => ` \"${props.value}\" no es un valor permitido para el perfil`
        }
    },
    cargo: {
        type: String,
        required: true,
        trim: true,
        lowercase: true
    },
    departamento: {
        type: String,
        required: true,
        trim: true,
        lowercase: true
    }
}

const userSchema = new mongoose.Schema(usuario);

const User = mongoose.model('User', userSchema);

export default User;



/*





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



*/