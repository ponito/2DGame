extends CharacterBody2D


const SPEED = 220.0
const JUMP_VELOCITY = -400.0
var Health = master.playerHealth:
	get:
		return Health
	set(value):
		if (0 >= value):
			collision_layer = 0
			get_node("Sprite").scale.x= 1
			anim.play("Death")
			Ocupied = 1
		Health = value

var Knowledge = master.playerKnowledge
var Stamina = 10:
	get:
		return Stamina
	set(value):
		if (value < Stamina):
			staminaRegTimer = 0.5
		Stamina = value
var maxStamina = 10
var staminaRegTimer = 0

var HurtTimer = 0
var Invincibility = 0

var Ocupied = 0


var isWallSliding = 0
var isLeftWallSliding = false
var isRightWallSliding = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#When needed create variable for Animation Player for Animation cutting
@onready var anim = get_node("AnimationPlayer")


func _ready():
	position.x = master.X
	position.y = master.Y

func _physics_process(delta):
	#HurtTimer
	if HurtTimer > 0:
		velocity.x = lerp(velocity.x, 0., 0.2)
		HurtTimer = max(0, HurtTimer - delta)
	#Invincibility
	if Invincibility > 0:
		Invincibility = max(0, Invincibility - delta)
		
	
	#Stamina
	if staminaRegTimer > 0:
		staminaRegTimer = max(0, staminaRegTimer - delta)
	
	if Stamina < maxStamina and staminaRegTimer == 0:
		Stamina = min(maxStamina, Stamina + 5*delta)


	
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
		if Stamina >= 0 && Ocupied <= 0:
			if Input.is_action_pressed("Left"):
				isWallSliding = 0.05
				isLeftWallSliding = true
				isRightWallSliding = false
				if velocity.y >= 0:
					Stamina -= delta * 1
					anim.play("Hang")
			elif Input.is_action_pressed("Right"):
				isWallSliding = 0.05
				isLeftWallSliding = false
				isRightWallSliding = true
				if velocity.y >= 0:
					Stamina -= delta * 1
					anim.play("Hang")
		else:
			isWallSliding = 0
	if (isWallSliding == 0):
			isLeftWallSliding = false
			isRightWallSliding = false


	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor() && Ocupied <= 0:
			if Stamina >= 2:
				anim.play("Jump")
				Stamina -= 2
				velocity.y = JUMP_VELOCITY
		elif isLeftWallSliding:
			if Stamina >= 2:
				anim.play("Jump")
				Stamina -= 2
				velocity.x = SPEED * 7 / 10
				velocity.y = JUMP_VELOCITY * 8 / 10
		elif isRightWallSliding:
			if Stamina >= 2:
				anim.play("Jump")
				Stamina -= 2
				velocity.x = -SPEED * 7 / 10
				velocity.y = JUMP_VELOCITY * 8 / 10
		
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if Input.is_action_pressed("Right")  && Ocupied <= 0:
		if is_on_floor():
			velocity.x = min(velocity.x + SPEED * delta * 4, SPEED)
		else:
				velocity.x = min(velocity.x + SPEED * delta * 2.7, SPEED)
		get_node("Sprite").scale.x= 1
		get_node("Sprite").position.x= 0
		if velocity.y == 0:
			anim.play("Move")
	elif Input.is_action_pressed("Left") && Ocupied <= 0:
		if is_on_floor():
				velocity.x = max(velocity.x - SPEED * delta * 4, -SPEED)
		else:
				velocity.x = max(velocity.x - SPEED * delta * 2.7, -SPEED)
		get_node("Sprite").scale.x= -1
		get_node("Sprite").position.x= -3.5
		if velocity.y == 0:
			anim.play("Move")


	elif is_on_floor():
		if not HurtTimer > 0:
			velocity.x = lerp(velocity.x, 0., 0.2)
		if velocity.y == 0 && Ocupied <= 0:
			anim.play("Idle")
		
	if velocity.y > 0 and isWallSliding <= 0 && Ocupied <= 0:
		anim.play("Fall")
	move_and_slide()
	









