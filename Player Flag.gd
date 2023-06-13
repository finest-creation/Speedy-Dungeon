extends Area2D

signal playerEntered

func _on_Player_Flag_body_entered(body):
	emit_signal("playerEntered")
