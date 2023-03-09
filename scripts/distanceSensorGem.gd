extends MeshInstance

var dist = 0
var maxDist = 50.0
var rawDist

func _ready():
	set_surface_material(0,get_active_material(0).duplicate())
	dist = maxDist

func _physics_process(delta):
	var space_state = get_world().direct_space_state
	var result = space_state.intersect_ray(global_translation, to_global(Vector3(0,maxDist*5,0)), [self,self.get_parent()])
	if not result.empty():
		rawDist = global_translation.distance_to(result.position)
	else:
		rawDist = maxDist
	
	dist += 0.5*(rawDist-dist)
		
	dist = min(dist,maxDist)
	var col = Color.from_hsv(210/360.0,1,(maxDist-dist)/maxDist)
	get_active_material(0).set_albedo(col)

