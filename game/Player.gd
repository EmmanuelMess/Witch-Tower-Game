extends Spatial

const MIN_VELOCITY = 0.5

var velocity = MIN_VELOCITY
var basic_acceleration = 1

func _ready():
	pass # Replace with function body.

func _process(delta):
	velocity -= delta * basic_acceleration
	
	velocity = max(velocity, MIN_VELOCITY)
	
	var direction = Vector3(0, 0, -1)
	translate_object_local(direction * velocity * delta)


func _on_TouchScreenButton_pressed():
	$bird/AnimationPlayer.play("Take 001_Armature_0")
	
	velocity += 10
	
	velocity = min(40, velocity)

func analog_force_change(inForce, _inStick):
	var analog_velocity
	
	if (inForce.length() < 0.1):
		analog_velocity = Vector2(0,0) 
	else:
		analog_velocity = Vector2(inForce.x, inForce.y)
	
	#Convert analog velocity to 0 , 1 , -1 
	analog_velocity = analog_velocity.normalized()
	
	analog_velocity.x = stepify(analog_velocity.x, 1)*20
	analog_velocity.y = stepify(analog_velocity.y, 1)*20
	
	translate_object_local(Vector3(analog_velocity.x, analog_velocity.y, 0)*0.01)
