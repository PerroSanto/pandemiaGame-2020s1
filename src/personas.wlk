import simulacion.*
import manzanas.*

class Persona {
 
	var property estaAislada = false
	var property estaInfectada = false
	var property diaDeInfeccion = null
	var property presentaSintomas = false
	var property respetaCuarentena = false

	method infectarse() {
		diaDeInfeccion = simulacion.diaActual()
		estaInfectada = true
		presentaSintomas = true
	}

	method debeCurarse() {
		if ((diaDeInfeccion - simulacion.diaActual()).abs() == 20) {
			estaInfectada = false
			presentaSintomas = false
		}
	}

	method pasarDia() {
		if (estaInfectada) {
			self.debeCurarse()
		}
	}

}

