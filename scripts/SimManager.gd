extends Spatial


func _ready():
	get_tree().call_group("simElements","initialize")

	

func _physics_process(delta):
	
	get_tree().call_group("simElements","doStuff",delta)

	
	
