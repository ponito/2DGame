extends CharacterBody2D


const SPEED = 220.0
const JUMP_VELOCITY = -400.0
var Health = 100
var isWallSliding = 0
var isLeftWallSliding = false
var isRightWallSliding = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#When needed create variable for Animation Player for Animation cutting
@onready var anim = get_node("AnimationPlayer")






func _physics_process(delta):
	#Health
	if Health <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://menu.tscn")
	
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
			if velocity.y >= 0:
				anim.play("Hang")
		elif Input.is_action_pressed("Right"):
			isWallSliding = 0.2
			isLeftWallSliding = false
			isRightWallSliding = true
			if velocity.y >= 0:
				anim.play("Hang")
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		anim.play("Jump")
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
		get_node("Sprite").scale.x= 1
		get_node("Sprite").position.x= 0
		if velocity.y == 0:
			anim.play("Move")
	elif Input.is_action_pressed("Left"):
			velocity.x = max(velocity.x - SPEED * delta * 4, -SPEED)
			get_node("Sprite").scale.x= -1
			get_node("Sprite").position.x= -3.5
			if velocity.y == 0:
				anim.play("Move")
		
	elif is_on_floor():
		velocity.x = lerp(velocity.x, 0., 0.2)
		if velocity.y == 0:
			anim.play("Idle")
	if velocity.y > 0 and isWallSliding <= 0:
		anim.play("Fall")
	move_and_slide()
	









