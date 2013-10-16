Port of Karsten Schmidts [GrayScott implementation](http://hg.postspectacular.com/toxiclibs/src/689ddcd9bea3/src.sim/toxi/sim/grayscott?at=default) into CoffeeScript


##API

###Constructor

    grayscott = new GrayScott(width, height)
    
#### `grayscott.setCoefficients(Du, Dv, F, k)`

Sets diffuse U , diffuse V, and the coefficient F and k

The defaults are 0.023, 0.077, 0.16, 0.08
    
#### `grayscott.reset()`

Reset the matrix to initial state

#### `grayscott.update()`

Updates the simulation for one time frame

#### `grayScott.v`

Float64Array holding the values of the simulation
