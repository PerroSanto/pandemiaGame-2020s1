import simulacion.*
import manzanas.*

class Persona {
	var property estaAislada = false
	var property estaInfectada = false
	var property diaDeInfeccion = 0
	var property presentaSintomas = false
	var property respetaCuarentena = false
	
	method infectarse() {
		diaDeInfeccion = simulacion.diaActual() // falta implementar
		estaInfectada = true
	}
}

