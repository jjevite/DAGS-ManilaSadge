extends Path2D

var enemy = preload("res://JJ/enemy.tscn")
@export var Player : CharacterBody2D

func _on_timer_timeout():
	get_parent()
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	$PathFollow2D.progress = rng.randi_range(0, 3664)
	var instance = enemy.instantiate()

	instance.global_position = $PathFollow2D.global_position
	add_child(instance)
