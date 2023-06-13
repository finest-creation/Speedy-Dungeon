extends Area2D

signal picked_up

func _on_Key_body_entered(body):
	visible = false
	emit_signal("picked_up")
	queue_free()
