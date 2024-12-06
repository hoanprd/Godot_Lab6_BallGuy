extends Area2D

@export var damageDeal : int

var timer: Timer
var hurt_timer: Timer
@onready var ap = $AnimationPlayer
var _damageDeal

func _ready():
	hurt_timer = get_node("HurtTimer")
	timer = get_node("Timer")
	_damageDeal = damageDeal
	ap.play("attack")

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player" && Global.health <= 5 && Global.health > 0):
		Global.health -= _damageDeal
		Global.get_hurt = true
		hurt_timer.start()
		timer.start()


func _on_timer_timeout() -> void:
	if (Global.health <= 5 && Global.health > 0):
		Global.health -= _damageDeal
		Global.get_hurt = true
		hurt_timer.start()
	else:
		timer.stop()


func _on_body_exited(body: Node2D) -> void:
	if (body.name == "Player" && Global.health <= 5):
		Global.get_hurt = false
		hurt_timer.stop()
		timer.stop()


func _on_hurt_timer_timeout() -> void:
	Global.get_hurt = false
