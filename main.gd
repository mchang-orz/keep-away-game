extends Node3D

#variables for spawning objects
@export var object_scene: PackedScene

#variables for grabbing 3d objects
var grabbed_object = null
var grab_distance = 10
var mouse = Vector2()
const DIST = 1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#mouse grabbin
	if grabbed_object:
		if grabbed_object is RigidBody3D:
			if grabbed_object.is_in_group("world") == false:
				lift_item(grabbed_object,get_grab_position(),delta)
			else:
				grabbed_object.position = get_grab_position()
				
#click and hold to grab
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse = event.position
	if event is InputEventMouseButton:
		if event.pressed == true and event.button_index == MOUSE_BUTTON_LEFT:
			Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
			get_mouse_world_pos(mouse)
		elif event.pressed == false and event.button_index == MOUSE_BUTTON_LEFT:
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			grabbed_object = null
			
func get_mouse_world_pos(mouse:Vector2):
	var space = get_world_3d().direct_space_state
	var start = get_viewport().get_camera_3d().project_ray_origin(mouse)
	var end = get_viewport().get_camera_3d().project_position(mouse, DIST)
	
	var params = PhysicsRayQueryParameters3D.new()
	params.from = start
	params.to = end 
	
	var result = space.intersect_ray(params)
	if result.is_empty() == false:
		grabbed_object = result.collider

func get_grab_position():
	return get_viewport().get_camera_3d().project_position(mouse, grab_distance)
	
func lift_item(item:RigidBody3D,target_position:Vector3,delta):
		#attach to objects to move
		var I = 500 #export to make adjustable
		var S = 20 #export to make adjustable
		var P = target_position - item.global_position
		var M = item.mass
		var V = item.linear_velocity
		var impulse = (I*P) - (S*M*V)
		item.apply_central_impulse(impulse * delta)

#simple spawner for objects , want to revise to spawn in an Area instead of on a path
func _on_mob_timer_timeout() -> void:
	var object = object_scene.instantiate()
	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var object_spawn_location = get_node("SpawnPath/SpawnLocation")
	# And give it a random offset.
	object_spawn_location.progress_ratio = randf()
	#apply global transform to spawn on path
	object.global_transform = object_spawn_location.global_transform
	var base_position = $HomeBase.position
	object.initialize(object_spawn_location.position, base_position)
	add_child(object)
	
	object.cleared.connect($UserInterface/ScoreLabel._on_object_cleared.bind())
	
func _on_home_base_hit() -> void:
	$MobTimer.stop()
