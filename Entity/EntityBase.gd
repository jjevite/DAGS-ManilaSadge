extends CharacterBody2D

@export var hp_max: int = 100
@export var hp: int = hp_max
@export var speed: int = 75

@onready var sprite = $Sprite2D
@onready var collisionShape = $CollisionShape2D
@onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	move()
	
func move():
	move_and_slide()
	
func die():
	queue_free()

