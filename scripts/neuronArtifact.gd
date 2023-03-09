extends KinematicBody

const Neuron = preload("res://scripts/DistroNeurons.gd")
var numNeurons = 10
var numConnections = 15
var eta = 0.01
var mat
var neurons = []
var rng = RandomNumberGenerator.new()
var colorSet = 0
var sensor1
var sensor2
var sensor3
var sensor4
var s1Neuron
var s2Neuron
var s3Neuron
var s4Neuron
var colorNeuron
var speedNeuron
var rotationNeuron
var otherArtifact
var brainNeuron1
var brainNeuron2
var brainNeuron3



func initialize():
	var body = get_node("body")
	mat = body.get_active_material(0).duplicate()
	body.set_surface_material(0,mat)
	rng.seed=hash("complex222")
	for i in range(numNeurons):
		neurons.append(Neuron.new())
		neurons[i].eta = eta
	for i in range(numNeurons):
		for j in range(2):
			var inpNeuronNum = rng.randi_range(0,numNeurons-1)
			neurons[i].inps.append(neurons[inpNeuronNum])
			neurons[i].inpWeights.append(0.2*rng.randfn())
		print(neurons[i].inps,"\n",neurons[i].inpWeights)
		
#	var children = get_children()
#	var childNeurons = []
#	
#	children = childNeurons
#	print(children)
#	for i in range(len(children)):
#		children[i].neuron = neurons[i]
	
	colorNeuron = neurons[0]
	speedNeuron = neurons[1]
	rotationNeuron = neurons[2]
	s1Neuron = neurons[3]
	s2Neuron = neurons[4]
	s3Neuron = neurons[5]
	s4Neuron = neurons[6]
	brainNeuron1 = neurons[7]
	brainNeuron2 = neurons[8]
	brainNeuron3 = neurons[9]
	
	get_node("n1").neuron = s1Neuron
	get_node("n2").neuron = s2Neuron
	get_node("n6").neuron = s3Neuron
	get_node("n7").neuron = s4Neuron
	get_node("n3").neuron = speedNeuron
	get_node("n4").neuron = rotationNeuron
	get_node("n5").neuron = colorNeuron
	get_node("n8").neuron = brainNeuron1
	get_node("n9").neuron = brainNeuron2
	get_node("n10").neuron = brainNeuron3
	
	brainNeuron1.eta = 0.001
	brainNeuron2.eta = 0.001
	brainNeuron3.eta = 0.001
	
	s1Neuron.eta = 0.01
	s2Neuron.eta = 0.01
	s3Neuron.eta = 0.01
#
#	brainNeuron2.inps = [s1Neuron,s3Neuron,brainNeuron1]
#	brainNeuron2.inpWeights = [1,1,-0.5]
#	brainNeuron3.inps = [s2Neuron,s4Neuron,brainNeuron1]
#	brainNeuron3.inpWeights = [1,1,0.5]
#	s1Neuron.inps = [brainNeuron3]
#	s1Neuron.inpWeights = [-0.5]
#	s2Neuron.inps = [brainNeuron2]
#	s2Neuron.inpWeights = [-0.5]
#
#
#	brainNeuron1.inps = [brainNeuron2,brainNeuron3,colorNeuron]
#	brainNeuron1.inpWeights = [-0.5,0.5,1]
#
#	colorNeuron.inps = [brainNeuron1]
#	colorNeuron.inpWeights = [-1]
#
#	speedNeuron.inps = [brainNeuron2]
#	speedNeuron.inpWeights = [1]
#
#	rotationNeuron.inps = [brainNeuron3,brainNeuron1]
#	rotationNeuron.inpWeights = [0.5,0.5]
	
	
	for child in get_children():
		if child.get("maxActivation"):
			child.initNeuroGems()

	sensor1 = get_node("s1")
	sensor2 = get_node("s2")
	sensor3 = get_node("s3")
	sensor4 = get_node("s4")
	
#	rotationNeuron.eta = 0.01


func preUp(delta):
	
	s1Neuron.input = sensor1.dist/10.0 - 0.5
	s2Neuron.input = sensor2.dist/10.0 - 0.5
	s3Neuron.input = sensor3.dist/10.0 - 0.5
	s4Neuron.input = sensor4.dist/10.0 - 0.5
	
	colorNeuron.error = colorNeuron.a-1
	brainNeuron1.error = brainNeuron1.a-2
	s1Neuron.error = s1Neuron.a+1
	s2Neuron.error = s2Neuron.a+2
	brainNeuron3.error = brainNeuron3.a+1
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
		
	if (self.name == "hexBoar"):
		print(brainNeuron1.inpWeights)
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
	move_and_collide((to_global(Vector3(0,0,1))-global_translation)*speedNeuron.a*delta*2)
	
	

