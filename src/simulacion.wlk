import personas.*
import manzanas.*

object simulacion {
	var property diaActual = 0
	const property manzanas = []
	
	// parametros del juego
	const property chanceDePresentarSintomas = 30
	const property chanceDeContagioSinCuarentena = 25
	const property chanceDeContagioConCuarentena = 2
	const property personasPorManzana = 10
	const property duracionInfeccion = 20

	/*
	 * este sirve para generar un azar
	 * p.ej. si quiero que algo pase con 30% de probabilidad pongo
	 * if (simulacion.tomarChance(30)) { ... } 
	 */ 	
	method tomarChance(porcentaje) = 0.randomUpTo(100) < porcentaje

	method agregarManzana(manzana) { manzanas.add(manzana) }
	
	method debeInfectarsePersona(persona, cantidadContagiadores) {
		const chanceDeContagio = if (persona.respetaCuarentena()) 
			self.chanceDeContagioConCuarentena() 
			else 
			self.chanceDeContagioSinCuarentena()
		return (1..cantidadContagiadores).any({n => self.tomarChance(chanceDeContagio) })	
	}
	
	method pasarUnDia(){
		manzanas.forEach({m => m.pasarUnDia()})
		diaActual += 1
		console.println("Terminó el día: " + (self.diaActual() - 1))
	}
	
	method crearPersona(){
        return new Persona()
    }

    method crearManzana() {
        const nuevaManzana = new Manzana()
        (1..self.personasPorManzana()).forEach({y => nuevaManzana.agregarHabitante(self.crearPersona())})
        return nuevaManzana
    }
    
    method cantidadTotalDeInfectados(){//Creado por David G.
    	return manzanas.sum({m => m.cantidadInfectados()})
    }
    
    method cantidadTotalDePersonas(){//Creado por David G.
    	return manzanas.sum({m => m.cantidadHabitantes()})
    }
    
    method cantidadTotalConSintomas(){//Creado por David G.
    	return manzanas.sum({m => m.cantidadConSintomas()})
    }
    
    method cantidadDeManzanas(){//Creado por David G.
    	return manzanas.size()
    }
    
    method estadoDeSimulacion(){//Creado por David G.
		console.println("Día: " + self.diaActual() + ", Total de personas: " + self.cantidadTotalDePersonas()
 		+ ", infectados: " + self.cantidadTotalDeInfectados() + ", con síntomas: " + self.cantidadTotalConSintomas())
	}
    
    method agregarPersonaEnManzanaAleatoria(persona){//Creado por David G.
    	//Seleccionamos una manzana aleatoria.
    	const unaManzana = manzanas.anyOne()
    	//Agregamos a la persona.
    	unaManzana.agregarHabitante(persona)
    }
    
    method agregarInfectadoEnManzanaAleatoria(){//Creado por David G.
    	const infectado = new Persona()
    	infectado.infectarse()
    	self.agregarPersonaEnManzanaAleatoria(infectado)
    }
    
    method obtenerManzanaDePosicion(posicion){//Creado en grupo.
    	return manzanas.find({m => m.position() == posicion})
    }
}
