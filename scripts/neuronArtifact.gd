extends KinematicBody

const Neuron = preload("res://scripts/DistroNeurons.gd")
var numNeurons = 5
var numConnections = 8
var eta = 0.001
var body
var mat
var neurons = []
var rng = RandomNumberGenerator.new()
var colorSet = 0
var sensor1
var sensor2
var s1Neuron
var s2Neuron
var colorNeuron
var speedNeuron
var rotationNeuron
var otherArtifact

#complex6
#complex7
#complex9 - *
#complex10 - *


func initialize():
	body = get_node("body")
	mat = body.get_active_material(0).duplicate()
	body.set_surface_material(0,mat)
	rng.seed=hash("complex10")
	for i in range(numNeurons):
		neurons.append(Neuron.new())
		neurons[i].eta = eta
	for i in range(numConnections):
		var inpNeuronNum = rng.randi_range(0,numNeurons-1)
		var toNeuron = rng.randi_range(0,numNeurons-1)
		
		neurons[toNeuron].inps.append(neurons[inpNeuronNum])
		neurons[toNeuron].inpWeights.append(rng.randfn())
		print(inpNeuronNum," to ",toNeuron,"\n",neurons[toNeuron].inpWeights)
		
#	var children = get_children()
#	var childNeurons = []
#	for child in children:
#		if child.get("maxActivation"):
#			childNeurons.append(child)
#	children = childNeurons
#	print(children)
#	for i in range(len(children)):
#		children[i].neuron = neurons[i]
	
	colorNeuron = neurons[0]
	speedNeuron = neurons[1]
	rotationNeuron = neurons[2]
	s1Neuron = neurons[3]
	s2Neuron = neurons[4]
	
	get_node("n1").neuron = s1Neuron
	get_node("n2").neuron = s2Neuron
	get_node("n3").neuron = speedNeuron
	get_node("n4").neuron = rotationNeuron
	get_node("n5").neuron = colorNeuron
	
	sensor1 = get_node("s1")
	sensor2 = get_node("s2")


func preUp(delta):
	
	s1Neuron.input = sensor1.dist/10.0 - 0.5
	s2Neuron.input = sensor2.dist/10.0 - 0.5
	colorNeuron.error = colorNeuron.a-1
#	speedNeuron.error = speedNeuron.a-2
#	neurons[4].input = min(global_translation.distance_to(otherArtifact.global_translation),3)
#	neurons[4].error = neurons[4].a-0
#	neurons[3].input = global_translation.distance_to(Vector3(0,1,0))
#	neurons[3].input = to_local(otherArtifact.global_translation).normalized().angle_to(Vector3(0,0,1))*0.5
#	neurons[3].error = neurons[3].a-otherArtifact.rotationNeuron.a
	
	for n in neurons:
		n.preBackUpdate()
	
func postUp(delta):
	for n in neurons:
		n.postUpdate()
	
	colorSet+=0.8*(colorNeuron.a-colorSet) 
	var h=0
	var v=0
	if colorSet >0:
		h = 170
	else:
		h = 0
	v = 2*abs(colorSet)/colorNeuron.maxActivation
	v = min(max(v,0),1)
	mat.set_albedo(Color.from_hsv(h/360.0,1,v))
	
	rotate_y(rotationNeuron.a*delta)
	move_and_collide(Vector3(0,-3,0)*delta)
	move_and_collide((to_global(Vector3(0,0,1))-global_translation)*speedNeuron.a*delta)
	
	

