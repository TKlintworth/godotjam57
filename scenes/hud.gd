extends CanvasLayer

@onready var GameTimer = $GameTimer
@onready var TimerText = $TimerText
@onready var StartButton = $CenterContainer/StartGameButton
@onready var PlayerCityHealthBar = $Control/PlayerCityHealthBar
@onready var GameOverText = $CenterContainer/GameOverText

var time_remaining = 0;

signal game_timer_timeout
signal start_game_pressed
signal attack_button_pressed
signal block_button_pressed
signal charge_button_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	TimerText.text = format_time(GameTimer.wait_time)
	time_remaining = GameTimer.wait_time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(delta)
	#time_remaining -= delta
	var formatted_time_remaining = format_time(GameTimer.time_left)
	TimerText.text = formatted_time_remaining
	#print(GameTimer.time_left)
	
func set_game_timer(time):
	time_remaining = time
	GameTimer.set_wait_time(time)

func start_game_timer():
	print("start game timer")
	GameTimer.paused = false
	GameTimer.start()
	#StartButton.visible = false

func stop_game_timer():
	GameTimer.stop()
	
func format_time(time):
	#print("format time")
	var minutes = int(time) / 60
	var seconds = int(time) % 60

	var formatted_time = str(minutes).lpad(2, "0") + ":" + str(seconds).lpad(2, "0")
	return formatted_time
	
func set_game_over_text(text):
	GameOverText.text = text
	GameOverText.visible = true

func _on_game_timer_ready():
	print("timer ready")


func _on_game_timer_timeout():
	emit_signal("game_timer_timeout")


func _on_start_game_button_pressed():
	StartButton.visible = false
	emit_signal("start_game_pressed")


func _on_attack_button_pressed():
	emit_signal("attack_button_pressed")


func _on_block_button_pressed():
	emit_signal("block_button_pressed")


func _on_charge_button_pressed():
	emit_signal("charge_button_pressed")


func _on_player_city_player_city_took_damage(damage):
	print("player city took damage hud")
	PlayerCityHealthBar.value -= damage
	
