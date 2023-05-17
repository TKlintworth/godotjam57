extends CanvasLayer

@onready var GameTimer = $GameTimer
@onready var TimerText = $TimerText

# Called when the node enters the scene tree for the first time.
func _ready():
	TimerText.text = format_time(GameTimer.wait_time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	TimerText.text = format_time(GameTimer.wait_time)
	
func set_game_timer(time):
	GameTimer.wait_time = time

func start_game_timer():
	GameTimer.start()

func stop_game_timer():
	GameTimer.stop()
	
func format_time(time):
	var minutes = int(time) / 60
	var seconds = int(time) % 60

	var formatted_time = str(minutes).lpad(2, "0") + ":" + str(seconds).lpad(2, "0")
	return formatted_time
