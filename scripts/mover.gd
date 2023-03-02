extends Spatial


var parent



func _ready():
	parent = get_parent()



func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		parent.translate(Vector3(0,1,0)*delta)
	elif Input.is_action_pressed("ui_down"):
		parent.translate(Vector3(0,-1,0)*delta)
