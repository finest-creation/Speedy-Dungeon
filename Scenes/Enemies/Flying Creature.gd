extends KinematicBody2D

export(int) var SPEED = 45

onready var player = get_node("../../Player/Knight")
onready var stats = $Stats
onready var animPlayer = $AnimationPlayer

var chase = false
var knockback = Vector2.ZERO

func turn_sprites():
	var direction = (player.position - position).normalized()
	if direction.x > 0:
		$AnimatedSprite.flip_h = false
	elif direction.x < 0:
		$AnimatedSprite.flip_h = true
	
func _ready():
	$AnimationPlayer.play("spawn")
	$AnimatedSprite2.visible = false

func _physics_process(delta):
	# Comportamento do inimigo.
	if chase == true:
		$AnimatedSprite.play("idle")
		var direction = (player.position - position).normalized()
		move_and_slide(direction * SPEED)
	
	# Knockback do combate.
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
	
	# Virar os sprites de acordo com a direção.
	turn_sprites()

# Quando o player acerta o inimigo.
func _on_Hurtbox_area_entered(area):
		stats.health -= 1
		$AnimationPlayer.play("hurt")
		knockback = area.knockback_vector * 120
	
func _on_Stats_no_health(): # Quando o inimigo ficar sem vida.
	chase = false
	$AnimatedSprite.visible = false
	$AnimatedSprite2.visible = true
	$death.play()
	$AnimatedSprite2.play("death")
	
func _on_AnimationPlayer_animation_finished(anim_name):
	chase = true

func _on_AnimatedSprite2_animation_finished():
	queue_free()
