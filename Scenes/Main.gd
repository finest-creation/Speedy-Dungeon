extends Node2D
	
var Flying_Creature = preload("res://Scenes/Enemies/Flying Creature.tscn")
var Goblin = preload("res://Scenes/Enemies/Goblin.tscn")
var bossGoblin = preload("res://Scenes/Enemies/BossGoblin.tscn")
var Slime = preload("res://Scenes/Enemies/Slime.tscn")
var Stats = preload("res://Scenes/Enemies/Stats.tscn")
var Key = preload("res://Scenes/Tiles/Prop - Key.tscn")

func _ready():
	$AudioStreamPlayer.play()
	
func _on_HUD_gameOver():
	get_tree().change_scene("res://Scenes/GameOverScreen.tscn")

func _on_PFlag_1_playerEntered():
	for pos in get_node(".").get_children():
		if pos.get_class() == "Position2D" && pos.name.begins_with("Main Hall"):
			var g = Goblin.instance()
			g.position = pos.position
			get_node("Enemies").add_child(g)

func _on_PFlag_2_body_entered(body):
	for pos in get_node(".").get_children():
		if pos.get_class() == "Position2D" && pos.name.begins_with("Key"):
			var s = Slime.instance()
			s.position = pos.position
			get_node("Enemies").add_child(s)

func _on_Door3_doorOpen():
	for pos in get_node(".").get_children():
		if pos.get_class() == "Position2D" && pos.name.begins_with("Empty"):
			var f = Flying_Creature.instance()
			f.position = pos.position
			get_node("Enemies").add_child(f)

func _on_Door4_doorOpen():
	for pos in get_node(".").get_children():
		if pos.get_class() == "Position2D" && pos.name.begins_with("Library"):
			var f = Goblin.instance()
			f.position = pos.position
			get_node("Enemies").add_child(f)

func _on_Door2_doorOpen():
	for pos in get_node(".").get_children():
		if pos.get_class() == "Position2D" && pos.name.begins_with("Barrel"):
			var f = Flying_Creature.instance()
			f.position = pos.position
			get_node("Enemies").add_child(f)

func _on_Door1_doorOpen():
	pass # Replace with function body.

func _on_BossDoor_doorClosed():
	for pos in get_node(".").get_children():
		if pos.get_class() == "Position2D" && pos.name.begins_with("Boss"):
			var f = bossGoblin.instance()
			f.position = pos.position
			get_node("Enemies").add_child(f)
