extends KinematicBody2D

export(int) var SPEED = 50

onready var player = get_node("../../Player/Knight")
onready var stats = $Stats

var chase = false 
var knockback = Vector2.ZERO

func turn_sprites():
	var direction = (player.position - position).normalized()
	if direction.x > 0:
		$AnimatedSprite.flip_h = false
		
		$SwordG/Sprite.flip_v = false
		$SwordG.rotation_degrees = 0
	elif direction.x < 0:
		$AnimatedSprite.flip_h = true
		
		$SwordG/Sprite.flip_v = true
		$SwordG.rotation_degrees = 180

func _ready():
	get_node("AnimationPlayer").play("spawn")
	$AnimatedSprite.visible = true
	$AnimatedSprite2.visible = false

func _physics_process(delta):
	# Comportamento do inimigo.
	if chase == true:
		$AnimatedSprite.play("run")
		var direction = (player.position - position).normalized()
		move_and_slide(direction * SPEED)
	
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
	# Virar os sprites de acordo com a direção.
	turn_sprites()

func _on_AnimationPlayer_animation_finished(anim_name):
	chase = true

func _on_HurtBox_area_entered(area):
		stats.health -= 1
		$AnimationPlayer.play("hurt")
		knockback = area.knockback_vector * 120

func _on_Stats_no_health():
	chase = false
	set_physics_process(false)
	$SwordG/Sprite.visible = false
	$AnimatedSprite.visible = false
	$AnimatedSprite2.visible = true
	$death.play()
	$AnimatedSprite2.play("death")

func _on_AnimatedSprite2_animation_finished():
	queue_free()
