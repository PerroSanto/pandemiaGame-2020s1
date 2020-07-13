import simulacionV2.*

object agente {

	var property image = "agente.png"
	var property position

	method cambiarPosicion(pos) {
		self.position(pos)
	}

	method moverDerecha() {
		self.cambiarPosicion(self.position().right(1))
	}

	method moverIzquierda() {
		self.cambiarPosicion(self.position().left(1))
	}
 
	method moverArriba() {
		self.cambiarPosicion(self.position().up(1))
	}

	method moverAbajo() {
		self.cambiarPosicion(self.position().down(1))
	}
	
	method manzanaActual(){
		return simulacion.obtenerManzanaDePosicion(self.position())
	}
	
	method aislarInfectadesConSintomas() {
		self.manzanaActual().aislarInfectades()
	}

	method acuarentenar() {
		self.manzanaActual().todosRespetanCuarentena()
	}

}
