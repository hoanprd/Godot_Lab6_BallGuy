extends Area2D

@export var damageDeal : int

var show_fire_timer : Timer
var off_fire_timer : Timer
var timer: Timer
var hurtTimer: Timer
@onready var colli = $CollisionShape2D
var _damageDeal

func _ready():
	show_fire_timer = get_node("ShowFireTimer")
	off_fire_timer = get_node("OffFireTimer")
	hurtTimer = get_node("HurtTimer")
	timer = get_node("Timer")
	_damageDeal = damageDeal
	#show_fire_timer.start()

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player" && Global.health <= 5 && Global.health > 0):
		Global.health -= _damageDeal
		Global.get_hurt = true
		#hurtTimer.start()
		#timer.start()
		print("hi")


func _on_timer_timeout() -> void:
	if (Global.health <= 5 && Global.health > 0):
		Global.health -= _damageDeal
		Global.get_hurt = true
		hurtTimer.start()
	else:
		timer.stop()


func _on_body_exited(body: Node2D) -> void:
	if (body.name == "Player" && Global.health <= 5):
		Global.get_hurt = false
		hurtTimer.stop()
		timer.stop()


func _on_hurt_timer_timeout() -> void:
	Global.get_hurt = false


func _on_show_fire_timer_timeout() -> void:
	colli.disabled = true
	off_fire_timer.start()


func _on_off_fire_timer_timeout() -> void:
	colli.disabled = false
	print("on")
	show_fire_timer.start()
