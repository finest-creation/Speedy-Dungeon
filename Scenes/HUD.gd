extends CanvasLayer

var PlayerStats = preload("res://Scenes/Player/Character.tscn").instance()

var numberKeys = 0
var numberLives = PlayerStats.get_node("Stats").max_health
signal hasKeys
signal gameOver

func _ready():
	$Keys/Counter.text = String(numberKeys)
	$HP/Counter.text = String(numberLives)
	
func _on_Key_picked_up():
	numberKeys += 1
	emit_signal("hasKeys")
	_ready()
	pass # Replace with function body.

func _on_Knight_lost_health():
	if numberLives > 1:
		numberLives -= 1
		$HP/ColorRect.margin_right -= 8
		_ready()
	else:
		emit_signal("gameOver")
