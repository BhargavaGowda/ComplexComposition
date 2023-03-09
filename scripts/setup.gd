extends Spatial

var arti1
var arti2
var arti3
func _ready():
	arti1=get_node("/root/Spatial/neuronArtifact1")
	arti2=get_node("/root/Spatial/neuronArtifact2")
#	arti3=get_node("/root/Spatial/neuronArtifact3")
#	arti1.otherArtifact = arti2
#	arti2.otherArtifact = arti3
#	arti3.otherArtifact = arti1
	
	
func _physics_process(delta):
		
	if Input.is_action_pressed("ui_accept"):
		arti1.speedNeuron.error = arti1.speedNeuron.a-3
		arti2.speedNeuron.error = arti2.speedNeuron.a-3



