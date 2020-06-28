import personas.*
import simulacion.*
import wollok.game.*

class Manzana {
	const property personas = []
	var property position
	
	method image() {
		// reeemplazarlo por los distintos colores de acuerdo a la cantidad de infectados
		// también vale reemplazar estos dibujos horribles por otros más lindos
		return "blanco_alt2.png"
	}
	
	method agregarHabitante(unaPersona){
		personas.add(unaPersona)
	}
	
	method agregarHabitantes(unConjuntoDePersonas){
		personas.addAll(unConjuntoDePersonas)
		//agrega un conjunto de personas a la manzana.
	}
	
	method cantidadHabitantes(){
		return personas.size() 
		//Devuelve la cantidad de personas que viven en una Manzana
	}
	
	// este les va a servir para el movimiento
	method esManzanaVecina(manzana) {
		return manzana.position().distance(position) == 1
	}

	method pasarUnDia() {
		self.transladoDeUnHabitante()
		//self.simulacionContagiosDiarios()
		self.simulacionContagiosDiariosPorCantidadDeInfectados()
		// despues agregar la curacion
	}
	
	method personaSeMudaA(persona, manzanaDestino) {
		// implementar
	}
	
	method cantidadInfectados(){
		return personas.count({persona => persona.estaInfectada()})
		// Devuelve la cantidad de personas infectadas
	}
//revisar
	method cantidadContagiadores() {
		return personas.count({persona => persona.estaInfectada() and not persona.estaAislada()})
		// Devuelve la cantidad de personas infectadas que no estan aisladas
	}
//nos	
	method simulacionContagiosDiariosPorCantidadDeInfectados(){
		(1..self.cantidadInfectados()).forEach({f=>self.simulacionContagiosDiarios()})
	}
	
	method noInfectades() {
		return personas.filter({ pers => not pers.estaInfectada() })
	} 	
	
	method simulacionContagiosDiarios() { 
		const cantidadContagiadores = self.cantidadContagiadores()
		if (cantidadContagiadores > 0) {
			self.noInfectades().forEach({ persona => 
				if (simulacion.debeInfectarsePersona(persona, cantidadContagiadores)) {
					persona.infectarse()
				}
			})
		}
	}
	
	method transladoDeUnHabitante() {
		const quienesSePuedenMudar = personas.filter({ pers => not pers.estaAislada() })
		if (quienesSePuedenMudar.size() > 2) {
			const viajero = quienesSePuedenMudar.anyOne()
			const destino = simulacion.manzanas().filter({ manz => self.esManzanaVecina(manz) }).anyOne()
			self.personaSeMudaA(viajero, destino)			
		}
	}
	
}
