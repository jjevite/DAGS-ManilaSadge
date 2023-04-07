extends CharacterBody2D

@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0,1)

@onready var animation_tree = $AnimationTree 
@onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	update_animation_parameters(starting_direction)
	

func update_animation_parameters(move_input :Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)

func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")

#Move all the physics process here
func _on_mobile_joystick_use_move_vector(move_vector):
	update_animation_parameters(move_vector)
	pick_new_state()

	velocity = move_vector * move_speed
	move_and_slide()
