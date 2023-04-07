extends CanvasLayer

signal use_move_vector

var move_vector = Vector2(0, 0)
var joystick_active = false

func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if $TouchScreenButton.is_pressed():
			move_vector = calculate_move_vector(event.position)
			joystick_active = true
			$JoystickHandle.position = event.position
			$JoystickHandle.visible = true
			limit_the_inner_circle(event.position)
			
	if event is InputEventScreenTouch:
		if event.pressed == false:
			joystick_active = false
			$JoystickHandle.visible = false
			

func _physics_process(delta):
	if joystick_active:
		emit_signal("use_move_vector", move_vector)
			
func calculate_move_vector(event_position):
	var texture_center_position = $TouchScreenButton.position + Vector2(64, 64)
	return (event_position - texture_center_position).normalized()
	
func limit_the_inner_circle(event_position):
	var texture_center = $TouchScreenButton.position + Vector2(64,64)
	var limit = 64 #in pixels
	
	if texture_center.distance_to(event_position) > limit:
		var limit_vector = move_vector * limit
		$JoystickHandle.position = texture_center + limit_vector
	else:
		$JoystickHandle.position = event_position
	
	$JoystickHandle.visible = true
