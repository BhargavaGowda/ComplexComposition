extends MeshInstance

var energyOutput = 0
export var baseOutput = 2
var mat
var eta = 0.3
var basePos
var t = 0

func initialize():
	mat = get_active_material(0).duplicate()
	set_surface_material(0,mat)
	basePos = global_translation
	
func doStuff(delta):
	t+= delta
	
	var elements = get_tree().get_nodes_in_group("simElements")
	for e in elements:		
		if not e == self:
			var dist = global_translation.distance_to(e.global_translation) 
			
			if dist<5 and e.get("energyConsumer"):
				e.energy += energyOutput*delta
#				print(e.name," drawing from ",self.name)
				
			if dist<2 and e.get("energyOutput"):
				print("interference")
				e.energyOutput-= (5-dist)/5*delta*(e.energyOutput/abs(e.energyOutput))
				
	var h=0
	var v=0
	if energyOutput>0:
		h = 170
	else:
		h = 340
	v = energyOutput/baseOutput
	v = min(max(v,0),1)
	mat.set_albedo(Color.from_hsv(h/360.0,1,v))
	
	global_translation = basePos*sin(0.2*t)
	global_translation.y = basePos.y
	
#	print(energyOutput-baseOutput)
	energyOutput -= (energyOutput-baseOutput)*eta*delta
	
	
				
			
	
