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
	}
}

