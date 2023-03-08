extends MeshInstance

const Neuron = preload("res://scripts/DistroNeurons.gd")
var numNeurons = 5
var neurons = []


func initialize():
	for i in range(numNeurons):
		neurons.append(Neuron.new())
		
	
func preUp(delta):
	pass
	
func postUp(delta):
	pass
	

