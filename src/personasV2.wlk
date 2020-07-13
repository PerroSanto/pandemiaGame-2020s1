import simulacionV2.*
import manzanasV2.*

class Persona {
 
	var property estaAislada = false
	var property estaInfectada = false
	var property diaDeInfeccion = null
	var property presentaSintomas = false
	var property respetaCuarentena = false

	method infectarse() {
		diaDeInfeccion = simulacion.diaActual()
		estaInfectada = true
	}
		
	method debeCurarse() {
		if ((diaDeInfeccion - simulacion.diaActual()).abs() == 5) {
			estaInfectada = false
			presentaSintomas = false
		}
	}

	method pasarDia() {
		if (estaInfectada) {
			self.debeCurarse()
		}
	}
	
	method sePuedeMudar(){ 
		return not self.estaAislada() and not self.respetaCuarentena()
	}

}