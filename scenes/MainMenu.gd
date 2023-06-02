extends CanvasLayer

@onready var main: Control = $Main





func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_exit_button_pressed():
	get_tree().get_root().propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit() # default behavior

