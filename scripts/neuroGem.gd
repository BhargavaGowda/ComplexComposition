extends MeshInstance


var neuron
var col = Color(0,0,0)
var maxActivation = 1.0

func initNeuroGems():
	set_surface_material(0,get_active_material(0).duplicate())
	maxActivation=neuron.maxActivation
	
func doStuff(delta):
	if neuron.a>0:
		col = Color(0,min(neuron.a/maxActivation,maxActivation),0)
	else:
		col = Color(2*min(-1*neuron.a/maxActivation,maxActivation),0,0)
	get_active_material(0).set_albedo(col)
