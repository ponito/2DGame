extends CharacterBody2D

const Health = 100
const SPEED = 220.0
const JUMP_VELOCITY = -450.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		if is_on_wall() and Input.is_action_pressed("Left"):
			velocity.x = SPEED
			velocity.y = JUMP_VELOCITY
		if is_on_wall() and Input.is_action_pressed("Right"):
			velocity.x = -SPEED
			velocity.y = JUMP_VELOCITY
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if Input.is_action_pressed("Right"):
		velocity.x = min(velocity.x + SPEED * delta * 4, SPEED)
	elif Input.is_action_pressed("Left"):
			velocity.x = max(velocity.x - SPEED * delta * 4, -SPEED)
	elif is_on_floor():
		velocity.x = lerp(velocity.x, 0., 0.2)

	move_and_slide()
