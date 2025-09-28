extends MeshInstance3D

func _ready() -> void:
	randomize()
	
	var material = self.get_active_material(0)
	if material == null:
		material = StandardMaterial3D.new()
		self.set_surface_override_material(0, material)
		
	var random_color = Color(randf(), randf(), randf())
	
	material.albedo_color = random_color
	

	
	
