extends KinematicBody2D

export(int) var speed = 100.0
signal lost_health

const Sword = preload("res://Scenes/Player/Sword Slash.tscn")
onready var ivFrames = $Timer
onready var swordHitBox = get_node("Hitbox/Sword Slash")
onready var stats = $Stats
var isInvincible = false

var knockback = Vector2.ZERO

func damageTaken():
	modulate.a = 0.5
	isInvincible = true
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
	$Timer.start()
	
func _on_Timer_timeout():
	modulate.a = 1
	$Hurtbox/CollisionShape2D.set_deferred("disabled", false)
	isInvincible = false
	
func _physics_process(delta):
	# Movimentação do personagem.
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
	velocity = velocity.normalized()
	move_and_slide(velocity * speed)
	
	
	
	# Controla a direção de atacar.
	if Input.is_action_just_pressed("ui_attack_left"):
		$Hitbox.rotation_degrees = 180
		swordHitBox.knockback_vector = Vector2.LEFT
		get_node("Hitbox/Sword Slash").attack()
	if Input.is_action_just_pressed("ui_attack_right"):
		$Hitbox.rotation_degrees = 0
		swordHitBox.knockback_vector = Vector2.RIGHT
		get_node("Hitbox/Sword Slash").attack()
	if Input.is_action_just_pressed("ui_attack_up"):
		$Hitbox.rotation_degrees = -90
		swordHitBox.knockback_vector = Vector2.UP
		get_node("Hitbox/Sword Slash").attack()
	if Input.is_action_just_pressed("ui_attack_down"):
		$Hitbox.rotation_degrees = 90
		swordHitBox.knockback_vector = Vector2.DOWN
		get_node("Hitbox/Sword Slash").attack()
	
	# Controle da visibilidade das animações do personagem.
	if velocity == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("idle")
		$idle.visible = true
		$running.visible = false
	else:
		$AnimationTree.get("parameters/playback").travel("running")
		$idle.visible = false
		$running.visible = true
	
	# Virar os sprites de acordo com a direção.
	if velocity.x > 0:
		$idle.flip_h = false
		$running.flip_h = false
		
		$Sword.rotation_degrees = 0
		$Sword/Sprite.flip_v = false
		
	elif velocity.x < 0:
		$idle.flip_h = true
		$running.flip_h = true
		
		$Sword.rotation_degrees = 180
		$Sword/Sprite.flip_v = true

func _on_Hurtbox_area_entered(area):
	if !isInvincible:
		emit_signal("lost_health")
		$hurt.play()
		damageTaken()


