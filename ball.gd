extends RigidBody3D

var impulse_strength = 1

signal cleared

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass
	
func initialize(start_position, goal_position):
	var direction = Vector3.ZERO - start_position
	apply_impulse(direction.normalized() * impulse_strength, goal_position)
#revist this later
#func look_follow(state, current_transform, target_position):
	#var up_dir = Vector3(0, 1, 0)
	#var cur_dir = current_transform.basis * Vector3(0,0,1)
	#var target_dir = (target_position - current_transform.origin).normalized()
	#var rotation_angle = acos(cur_dir.x) - acos(target_dir.x)
#
	#state.set_angular_velocity(up_dir * (rotation_angle / state.get_step()))
	#
#func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	#var target_position = get_node("/root/Main/HomeBase").get_global_transform().origin
	#look_follow(state, get_global_transform(), target_position)

	
func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	cleared.emit()
	queue_free()
	
