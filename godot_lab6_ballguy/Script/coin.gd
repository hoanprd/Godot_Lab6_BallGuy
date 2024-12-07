extends Area2D

@export var value : int

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.coin += value
		queue_free()
