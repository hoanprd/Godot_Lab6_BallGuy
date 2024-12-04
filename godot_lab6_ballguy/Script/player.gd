extends RigidBody2D

@onready var move_right_force = Vector2(10, 0)
@onready var move_left_force = Vector2(-10, 0)
@onready var jump_force = Vector2(0, -200)
@onready var move_speed_max = 50
@onready var can_jump = false
@onready var sprite = $Sprite2D
@onready var ray_foot_1 = $RayCast1
@onready var ray_foot_2 = $RayCast2
@onready var ray_foot_3 = $RayCast3
@onready var ray_foot_4 = $RayCast4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.win == false:
		if Global.lose_area == false and Global.lose_kill == false:
			if Global.get_hurt == true:
				#AudioServer.set_bus_mute(sfxBus, false)
				#hurtSound.play()
				pass
			set_state()
			process_input()

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
		
	if Input.is_action_just_pressed("ui_accept") and can_jump == true:
		#AudioServer.set_bus_mute(sfxBus, false)
		#jumpSound.play()
		self.apply_impulse(jump_force, Vector2(0, 0))
