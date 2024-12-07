extends RigidBody2D

@onready var move_right_force = Vector2(10, 0)
@onready var move_left_force = Vector2(-10, 0)
@onready var jump_force = Vector2(0, -30)
@onready var move_speed_max = 50
@onready var can_jump = false
@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var ray_foot_1 = $RayCast1
@onready var ray_foot_2 = $RayCast2
@onready var ray_foot_3 = $RayCast3
@onready var ray_foot_4 = $RayCast4
@onready var end_anim_timer = $EndAnimTimer
@onready var music_bus = AudioServer.get_bus_index("Music")
@onready var sfx_bus = AudioServer.get_bus_index("SFX")
@onready var jump_sound = $JumpEffect
@onready var hurt_sound = $HurtEffect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioServer.set_bus_mute(music_bus, false)
	AudioServer.set_bus_mute(sfx_bus, false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.stop_game == false:
		if Global.win == false:
			if Global.lose_kill == false:
				if Global.get_hurt == true:
					AudioServer.set_bus_mute(sfx_bus, false)
					hurt_sound.play()
				set_state()
				process_input()
			else:
				Global.stop_game = true
				self.freeze = true
				ap.play("die")
	else:
		AudioServer.set_bus_mute(music_bus, true)
		AudioServer.set_bus_mute(sfx_bus, true)

func set_state():
	if ray_foot_1.is_colliding() or ray_foot_2.is_colliding() or ray_foot_3.is_colliding() or ray_foot_4.is_colliding():
		can_jump = true
	else:
		can_jump = false

func process_input():
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		if self.linear_velocity.x < move_speed_max:
			self.apply_impulse(move_right_force, Vector2(0,0))
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		if self.linear_velocity.x > -move_speed_max:
			self.apply_impulse(move_left_force, Vector2(0,0))
		direction.x -= 1
		
	if Input.is_action_just_pressed("ui_accept") and can_jump == true and self.position.x >= 40 and self.position.x <= 250:
		AudioServer.set_bus_mute(sfx_bus, false)
		jump_sound.play()
		ap.play("jump")
		end_anim_timer.start()
		self.apply_impulse(jump_force, Vector2(0, 0))


func _on_end_anim_timer_timeout() -> void:
	ap.play("idle")
