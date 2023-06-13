extends Area2D

onready var animation_player = $AnimationPlayer

enum STATES {IDLE, ATTACK} # Estados da espada no jogo.

var current_state = STATES.IDLE # Estado atual -> PARADA.

export(int) var damage = 1 # Dano da espada.
var knockback_vector = Vector2.ZERO # Vetor auxiliar para knockback nos golpes.

func _ready():
	set_physics_process(false) # Não quero que o jogo já analise os corpos no motor gráfico. Apenas quando atacar.
	
func attack(): # Vai ser chamado pelo personagem quando o estado for ATACAR (ATTACK).
	_change_state(STATES.ATTACK)
	
func _change_state(new_state):
	current_state = new_state
	
	match current_state:
		STATES.IDLE:
			set_physics_process(false)
		STATES.ATTACK:
			set_physics_process(true)
			get_node("AnimationPlayer").play("attack")

func _on_AnimationPlayer_animation_finished(anim_name):
	if name == "attack":
		_change_state(STATES.IDLE)




