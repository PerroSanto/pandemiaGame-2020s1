import personas.*
import simulacion.*
import wollok.game.*

class Manzana {
	const property personas = []
	var property position
	
	method image() {
		// "reeemplazarlo por los distintos colores de acuerdo a la cantidad de infectados
		// también vale reemplazar estos dibujos horribles por otros más lindos"
		if(self.estanTodosInfectados()){
			return "rojo_alt.png"
		}else if(self.cantidadInfectados().between(8,self.cantidadHabitantes() - 1)){
			return "naranjaOscuro_alt.png"
		}else if(self.cantidadInfectados().between(4,7)){
			return "naranja_alt.png"
		}else if(self.cantidadInfectados().between(1,3)){
			return "amarillo_alt.png"
		}else{
			return "blanco_alt2.png"
		}
	}
	
	method estanTodosInfectados(){
		return personas.all({persona => persona.estaInfectada()})
	}
	
	method agregarHabitante(unaPersona){
		personas.add(unaPersona)
	}
	
	method agregarHabitantes(unConjuntoDePersonas){//agrega un conjunto de personas a la manzana.
		personas.addAll(unConjuntoDePersonas)
		
	}
	
	method borrarHabitante(unaPersona){
		personas.remove(unaPersona)
	}
	
	method cantidadHabitantes(){//Devuelve la cantidad de personas que viven en una Manzana
		return personas.size() 
		
	}
	
	// este les va a servir para el movimiento
	method esManzanaVecina(manzana) {
		return manzana.position().distance(position) == 1
	}

	method pasarUnDia() {
		self.transladoDeUnHabitante()
		self.simulacionContagiosDiariosPorCantidadDeInfectados()
		personas.forEach({p => p.pasarDia()})
	}
	
	method personaSeMudaA(persona, manzanaDestino) {
		self.borrarHabitante(persona)
		manzanaDestino.agregarHabitante(persona)
	}
	
	method cantidadConSintomas(){
		return personas.count({p => p.presentaSintomas()})
	}
	
	method cantidadInfectados(){// Devuelve la cantidad de personas infectadas
		return personas.count({persona => persona.estaInfectada()})
		
	}

	method cantidadContagiadores() {// Devuelve la cantidad de personas infectadas que no estan aisladas
		return personas.count({persona => persona.estaInfectada() and not persona.estaAislada()})
		
	}
	
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
					persona.presentaSintomas(simulacion.puedePresentarSintomas())
					
				}
			})
		}
	}
	 
	method transladoDeUnHabitante() {
		const quienesSePuedenMudar = personas.filter({ pers => pers.sePuedeMudar() })
		if (quienesSePuedenMudar.size() > 2) {
			const viajero = quienesSePuedenMudar.anyOne()
			const destino = simulacion.manzanas().filter({ manz => self.esManzanaVecina(manz) }).anyOne()
			self.personaSeMudaA(viajero, destino)			
		}
	}
	
	method habitantesInfectadesConSintomas(){
		return personas.filter({p => p.estaInfectada() and p.presentaSintomas()})
	}
	
	method aislarInfectades(){
		self.habitantesInfectadesConSintomas().forEach({p => p.estaAislada(true)})
	}
	
	method todosRespetanCuarentena(){
		personas.forEach({p => p.respetaCuarentena(true)})
	}
	
	
}
