
class Actividad {
		
	method implicaEsfuerzo()
	method sirveParaBroncearse()
	method diasDeActividad()
}

class Viaje inherits Actividad {
	const property idiomas = #{}
	
	method viajeInteresante() = idiomas.size() > 1
	method esRecomendadaPara(unSocio) = self.viajeInteresante() and unSocio.leAtrae(self) and !unSocio.actividades().contains(self)
}

class Playa inherits Viaje {
	const largoDePlaya
	
	override method diasDeActividad() = largoDePlaya / 500
	override method implicaEsfuerzo() = largoDePlaya > 1200
	override method sirveParaBroncearse() = true 
}

class Ciudad inherits Viaje {
	const cantAtracciones
	
	override method diasDeActividad() = cantAtracciones / 2
	override method implicaEsfuerzo() = cantAtracciones.between(5,8)
	override method sirveParaBroncearse() = false 
	override method viajeInteresante() = super() or cantAtracciones == 5
}

class Tropical inherits Ciudad {
	override method diasDeActividad() = super() + 1
    override method sirveParaBroncearse() = not super()
	 
}


class Trekking inherits Viaje {
	const km
	const diasDeSol
	
	override method diasDeActividad() = km / 2
	override method implicaEsfuerzo() = km > 80
	override method sirveParaBroncearse() = diasDeSol > 200 or (diasDeSol.between(100,200) and  km > 120 )
	override method viajeInteresante() = super() or diasDeSol > 140
}


class ClaseGimnasia inherits Actividad {
	const property  idiomas = #{"Espaniol"}
	
	override method diasDeActividad() = 1
	override method implicaEsfuerzo() = true
	override method sirveParaBroncearse() = false 
     method esRecomendadoPara(unSocio) = unSocio.edad().between(20,30)
}

class TallerLiterario inherits Actividad {
	const property libros = #{}
	const idiomas = libros.map({p => p.idiomas()}).asSet()
		
	override method diasDeActividad() = libros.size() + 1
	override method implicaEsfuerzo() = libros.any({p =>p.cantPaginas() > 500}) or 
	                                    (libros.size() > 1 and libros.all({p =>p.autor() == self.algunAutorDeLosLibros()}) )
	method algunAutorDeLosLibros() = libros.anyOne().autor()                                   
	override method sirveParaBroncearse() = false 
    method esRecomendadoPara(unSocio) = unSocio.idiomas().size() > 1
}