extends CharacterBody2D

const Health = 100
const SPEED = 220.0
const JUMP_VELOCITY = -400.0
var isWallSliding = 0
var isLeftWallSliding = false
var isRightWallSliding = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")







func _physics_process(delta):
	# Check for wall sliding
	isWallSliding = max(isWallSliding - delta, 0)
	if not is_on_wall():
		isWallSliding = 0
	if (isWallSliding == 0):
			isLeftWallSliding = false
			isRightWallSliding = false
			
			
	# Add the gravity.
	if not is_on_floor():
		if isWallSliding > 0 and velocity.y > 0:
			velocity.y = min(velocity.y + gravity * delta / 2, SPEED / 4)
		else:
			velocity.y += gravity * delta
			
	if is_on_wall_only():
		if Input.is_action_pressed("Left"):
			isWallSliding = 0.2
			isLeftWallSliding = true
			isRightWallSliding = false
		elif Input.is_action_pressed("Right"):
			isWallSliding = 0.2
			isLeftWallSliding = false
			isRightWallSliding = true
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif isLeftWallSliding:
			velocity.x = SPEED * 3 / 4
			velocity.y = JUMP_VELOCITY * 4 / 5
		elif isRightWallSliding:
			velocity.x = -SPEED * 3 / 4
			velocity.y = JUMP_VELOCITY * 4 / 5
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if Input.is_action_pressed("Right"):
		velocity.x = min(velocity.x + SPEED * delta * 4, SPEED)
		$AnimationPlayer.play("Move")
		get_node("Sprite").scale.x= 1
		get_node("Sprite").position.x= 0
	elif Input.is_action_pressed("Left"):
			velocity.x = max(velocity.x - SPEED * delta * 4, -SPEED)
			$AnimationPlayer.play("Move")
			get_node("Sprite").scale.x= -1
			get_node("Sprite").position.x= -3.5
			
	elif is_on_floor():
		velocity.x = lerp(velocity.x, 0., 0.2)

	move_and_slide()
	







#Animationen Idleing
func _process(delta):
	if ( velocity.x >= -1 && velocity.x < 1 ):
		$AnimationPlayer.play("Idle")


