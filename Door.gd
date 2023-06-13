extends StaticBody2D

onready var props = get_node(".")
signal doorOpen
signal doorClosed

func _ready():
	$AnimatedSprite.play("closed")
	
	var currentDoor = get_name()
	
	match currentDoor:
		"BossDoor":
			$NearDoor/CollisionShape2D.set_deferred("disabled", true)

func _on_NearDoor_body_entered(body):
	var currentDoor = get_name()
	
	match currentDoor:
		"Door1":
			
			# Porta abrindo.
			if $AnimatedSprite.animation == "open":
				return
			else:
				$doorOpening.play()
				$AnimatedSprite.play("opening")
				yield($AnimatedSprite, "animation_finished")
				$AnimatedSprite.play("open")
				set_collision_mask_bit(0, false)
				set_collision_mask_bit(1, false)
				set_physics_process(false)
				emit_signal("doorOpen")
		
		"Door2":
			
			# Porta abrindo.
			if $AnimatedSprite.animation == "open":
				return
			else:
				$doorOpening.play()
				$AnimatedSprite.play("opening")
				yield($AnimatedSprite, "animation_finished")
				$AnimatedSprite.play("open")
				set_collision_mask_bit(0, false)
				set_collision_mask_bit(1, false)
				set_physics_process(false)
				emit_signal("doorOpen")
		
		"Door3":
			
			# Porta abrindo.
			if $AnimatedSprite.animation == "open":
				return
			else:
				$doorOpening.play()
				$AnimatedSprite.play("opening")
				yield($AnimatedSprite, "animation_finished")
				$AnimatedSprite.play("open")
				set_collision_mask_bit(0, false)
				set_collision_mask_bit(1, false)
				set_physics_process(false)
				emit_signal("doorOpen")
		
		"Door4":
			
			# Porta abrindo.
			if $AnimatedSprite.animation == "open":
				return
			else:
				$doorOpening.play()
				$AnimatedSprite.play("opening")
				yield($AnimatedSprite, "animation_finished")
				$AnimatedSprite.play("open")
				set_collision_mask_bit(0, false)
				set_collision_mask_bit(1, false)
				set_physics_process(false)
				emit_signal("doorOpen")

func _on_NearDoor_body_exited(body):
	var currentDoor = get_name()
	
	
	match currentDoor:
		"BossDoor":
			# Porta fechando.
			if $AnimatedSprite.animation == "closed":
				return
			else:
				$CollisionShape2D.set_deferred("disabled", false)
				$AnimatedSprite.play("closed")
				emit_signal("doorClosed")


func _on_HUD_hasKeys():
	var currentDoor = get_name()
	
	match currentDoor:
		"BossDoor":
	# Porta abrindo.
			$doorOpening.play()
			$AnimatedSprite.play("open")
			$NearDoor/CollisionShape2D.set_deferred("disabled", false)
			$CollisionShape2D.set_deferred("disabled", true)
