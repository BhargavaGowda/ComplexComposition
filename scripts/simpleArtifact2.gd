extends MeshInstance

var energyConsumer = 1
var energy = 0

func initialize():
	pass
	
func doStuff(delta):
	energy = max(energy,0)
	energy*=0.99
	
	if(global_translation.y>3):
		translate(Vector3(0,-0.25,0)*delta)
	
	
	translate(Vector3(0,0,max(5*energy,1))*delta)
	energy-=delta
	
	print(energy)
	
	var elements = get_tree().get_nodes_in_group("simElements")
	for e in elements:		
		if not e == self and e.get("energyOutput"):
			var dist = global_translation.distance_to(e.global_translation)
			if dist<5:
				rotate_object_local(Vector3(0,1,0),delta*to_local(e.global_translation).x)
				rotate_object_local(Vector3(1,0,0),0.1*delta*to_local(e.global_translation).z)
				
				
				
				
		
#	print(global_translation.y)
		
		
