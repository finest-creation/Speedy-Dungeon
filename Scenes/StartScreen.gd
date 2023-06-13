extends CanvasLayer

func _ready():
	$AudioStreamPlayer.play()

func _on_Controls_pressed():
	get_tree().change_scene("res://Scenes/ControlsScreen.tscn")

func _on_Quit_pressed():
	get_tree().quit()

func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")
