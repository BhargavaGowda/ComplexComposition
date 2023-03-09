extends Spatial

var ele1
var ele2

func initialize():
	ele1 = get_node("neuronArtifact1")
	ele1.initialize()
	
func preUp(delta):

	ele1.preUp(delta)

	
	
func postUp(delta):
	ele1.postUp(delta)

