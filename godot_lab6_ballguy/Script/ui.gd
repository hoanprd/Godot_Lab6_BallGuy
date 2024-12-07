extends Control

@onready var healthBar = $HPBar
@onready var pointsLabel = $CoinLabel

var gameOver: bool
var health_label: Label
var points_label: Label
var winLose_panel: Panel
var winLose_label: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	healthBar.value = Global.health
	winLose_panel = get_node("WinLosePanel")
	winLose_label = get_node("WinLosePanel/WinLoseLabel")
	winLose_panel.visible = false
	gameOver = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.get_hurt:
		pass
	if Global.win == true:
		winLose_label.text = "YOU PASS"
	
	if (Global.health <= 0 || Global.stop_game):
		if (!gameOver):
			gameOver = true
			winLose_panel.visible = true
			if Global.health <= 0:
				Global.lose_kill = true
				winLose_label.text = "YOU DIE"
	
	updateUI()
	HealthUpdate()

func HealthUpdate():
	if Global.get_hurt == true or Global.get_health == true:
		healthBar.value = Global.health
		Global.get_health = false

func updateUI():
	pointsLabel.text = str(Global.coin)


#func _on_exit_game_timer_timeout() -> void:
	#get_tree().quit()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
