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
#
#	print(energy)
	
	rotate_object_local(Vector3(0,0,1),-1*delta*(get_node("leftTip").global_translation.y-get_node("rightTip").global_translation.y))
	
	target(0.1*delta,Vector3(0,5,0))
	
	var elements = get_tree().get_nodes_in_group("simElements")
	for e in elements:
		if not e == self:
			var dist = global_translation.distance_to(e.global_translation)
			if e.get("energyOutput") and dist<10:
				target(delta*pow((10-dist),2)/100.0,e.global_translation)
#				print(1)
			if e.get("energyConsumer") and dist<5:
				target(2*delta,-1*(e.global_translation - global_translation)+global_translation)
				
				
			
				
				
				
func target(delta,point):
	rotate_object_local(Vector3(0,1,0),delta*to_local(point).x)
	rotate_object_local(Vector3(1,0,0),-0.5*delta*to_local(point).y)
	
