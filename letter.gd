extends MeshInstance3D

func _ready() -> void:
	randomize()
	
	var material = self.get_active_material(0)
	if material == null:
		material = StandardMaterial3D.new()
		self.set_surface_override_material(0, material)
		
	var random_color = Color(randf(), randf(), randf())
	
	material.albedo_color = random_color
	
func _unhandled_input(event: InputEvent) -> void:
	
	var current_text: String = ""
	var regex = RegEx.new()
	regex.compile("[a-zA-Z]")
	
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		var key_char = event.as_text()
		var key_search = regex.search(key_char)
		
		if key_char.length() == 1 and key_search:
			current_text = key_char
			print(current_text)
			
		mesh.text = current_text
