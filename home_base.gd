extends Node3D

signal hit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func die():
	hit.emit()
	queue_free()
	print("ded")

func _on_detector_body_entered(body: Node3D) -> void:
	die()
