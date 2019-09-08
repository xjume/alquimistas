object alquimista{
  var itemsDeCombate = []
  var itemsDeRecoleccion = []
   
  method cantidadDeItemsDeCombate(){
    return itemsDeCombate.size()
  }
  
  method cantidadDeItemsDeCombateEfectivos(){
    return itemsDeCombate.count({ 
      itemDeCombate => itemDeCombate.esEfectivo()
    })
  }
  
  method cantidadDeItemsDeRecoleccion(){
	return itemsDeRecoleccion.size()
  }
  
  method agregarItemDeCombate(item){
  	itemsDeCombate.add(item)
  }
  
  method agregarItemDeRecoleccion(item){
  	itemsDeRecoleccion.add(item)
  }
    
  method tieneCriterio(){
    return self.cantidadDeItemsDeCombateEfectivos() >= self.cantidadDeItemsDeCombate() / 2
  }
  
  method esBuenExplorador(){
  	return self.cantidadDeItemsDeRecoleccion() >= 3
  } 
  
  method capacidadOfensiva(){
	return itemsDeCombate.sum({ item => item.capacidad() })
  }
  
  method calidadPromedioDeTodosLosItems(){
  	var sumC = itemsDeCombate.sum(itemsDeCombate.forEach({ item => item.calidad() }))
	var sumR = 30 + 0.1 * itemsDeRecoleccion.sum(itemsDeRecoleccion.forEach({ item => item.calidad() }))
  	
  	var divisor = self.cantidadDeItemsDeCombate() + self.cantidadDeItemsDeRecoleccion()
  	
	var sum = sumC + sumR 
  	
  	return sum / divisor
  }
  
  method esProfesional(){
  	return 
  		self.calidadPromedioDeTodosLosItems() > 50 &&
  		self.cantidadDeItemsDeCombate() == self.cantidadDeItemsDeCombateEfectivos() &&
  		self.esBuenExplorador()
  }
}

object bomba{
  var danio = 102
  var materiales = []
  
  method esEfectivo(){
  	return danio > 100
  }
  
  method capacidad(){
  	return danio / 2
  }
  
  method calidad(){
  	return materiales.min( materiales.forEach({ material => material.calidad() }) )
  }
}

object pocion{
  var poderCurativo = 60
  var materiales = []
  
  method esEfectivo(){
  	return poderCurativo > 50 && self.creadaConMaterialMistico()
  }
  
  method creadaConMaterialMistico(){
  	return materiales.any({ material => material.esMistico() })
  }
  
  method capacidad(){
  	return poderCurativo + materiales.count({ material => material.esMistico() }) * 10
  }
  
  method calidad(){
  	return (materiales.find({ material => material.esMistico() })).calidad()
  }
}

object debilitador{
  var potencia = 0
  var materiales = []
  
  method esEfectivo(){
  	return potencia > 0 && self.creadaConMaterialMistico().negate()
  }
  
  method creadaConMaterialMistico(){
  	return materiales.any({ material => material.esMistico() })
  }
  
  method capacidad(){
  	if (self.creadaConMaterialMistico())
  	  return 12
  	else 
  	  return 5
  }
  
  method calidad(){
  	var materialesOrdenados = materiales.sortedBy({ 
  		mat1, mat2 => mat1.calidad() < mat2.calidad()
  	})
  	return materialesOrdenados.take(2).sum() / 2
  }
}

object material{
	var calidad = 0
	
	method calidad(){
	  return calidad
	}

	method esMistico(){
		return true
	}	
}
