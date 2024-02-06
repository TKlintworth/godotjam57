# Taken from kidscancode.org

extends Node

var num_players = 8
var bus = "Master"

var available = []  # The available players.
var queue = []  # The queue of sounds to play.


func _ready():
	# Create the pool of AudioStreamPlayer nodes.
	for i in num_players:
		var p = AudioStreamPlayer.new()
		add_child(p)
		available.append(p)
		#p.connect("finished", _on_stream_finished)
		#p.finished.connect(_on_stream_finished)
		
		p.connect("finished", Callable(self, "_on_stream_finished"))

		p.bus = bus


func _on_stream_finished():
	print("STREAM FINISHED")
	available.append(AudioStreamPlayer.new())
	print("Stream finished. Available players:", available.size())
	# When finished playing a stream, make the player available again.
	#emit_signal("stream_finished", [stream])


func play(sound_path):
	queue.append(sound_path)


func _process(delta):
	# Play a queued sound if any players are available.
	if not queue.is_empty() and not available.is_empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		available.pop_front()


func _on_ready():
	pass
	#play("res://assets/sounds/feudal_final.wav")
