extends MeshInstance

var dist = 0
var maxDist = 10.0

func _ready():
	set_surface_material(0,get_active_material(0).duplicate())

func _physics_process(delta):
	var space_state = get_world().direct_space_state
	var result = space_state.intersect_ray(global_translation, to_global(Vector3(0,100,0)), [self,self.get_parent()])
	if not result.empty():
		var rawDist = global_translation.distance_to(result.position)
		dist += 0.5*(rawDist-dist)
		

	var col = Color.from_hsv(200/360.0,1,(maxDist-dist)/maxDist)
	get_active_material(0).set_albedo(col)

