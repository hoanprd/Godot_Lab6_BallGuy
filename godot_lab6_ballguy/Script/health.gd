extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.get_health = true
		Global.health += 2
		if Global.health > 5:
			Global.health = 5
		queue_free()
