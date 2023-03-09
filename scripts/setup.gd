extends Spatial

var arti1
var arti2
var arti3
func _ready():
	arti1=get_node("/root/Spatial/hexBoar")
#	arti2=get_node("/root/Spatial/neuronArtifact2")
#	arti3=get_node("/root/Spatial/neuronArtifact3")
#	arti1.otherArtifact = arti2
#	arti2.otherArtifact = arti3
#	arti3.otherArtifact = arti1
	
	
func _physics_process(delta):
		pass
#	if Input.is_action_pressed("ui_accept"):
#		arti1.speedNeuron.error = arti1.speedNeuron.a-3
##		arti2.speedNeuron.error = arti2.speedNeuron.a-3
##		arti3.speedNeuron.error = arti3.speedNeuron.a-3
#	if Input.is_action_pressed("ui_down"):
#		arti1.rotationNeuron.error = arti1.rotationNeuron.a
#	if Input.is_action_pressed("ui_up"):
#		arti1.colorNeuron.input = -1
#	if arti1.get("sensor1"):
#		print(arti1.sensor1.dist)



