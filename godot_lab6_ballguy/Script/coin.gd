extends Area2D

var label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#label = get_tree().current_scene.get_node("CanvasLayer/UI")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	Global.coin += 1
	#label.text = Global.coin
