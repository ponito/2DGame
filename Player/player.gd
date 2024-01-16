extends CharacterBody2D


const SPEED = 360.0
const JUMP_VELOCITY = -450.0

var maxHealth = master.playerHealth
var Health = master.playerHealth:
	get:
		return Health
	set(value):
		if (0 >= value):
			collision_layer = 0
			get_node("Sprite").scale.x= 1
			velocity.x = 0
			anim.play("Death")
			Ocupied = 1
		if Health > maxHealth:
			Health = maxHealth
		Health = value

var Knowledge = master.playerKnowledge
var Stamina = 10:
	get:
		return Stamina
	set(value):
		if (value < Stamina):
			staminaRegTimer = 0.5
		if (value < 0):
			staminaRegTimer = 3.5
			value = 0
		Stamina = value
var maxStamina = 10
var maxtStamina = maxStamina
var staminaRegTimer = 0
var maxFokus = 10.0
var Fokus = 10.0:
	get:
		return Fokus
	set(value):
		Fokus = value
		maxtStamina = maxStamina * 0.5 + maxStamina * 0.5 *(Fokus/maxFokus)
		if Stamina > maxtStamina:
			Stamina = maxtStamina
			FokusUse.emit()
	

var HurtTimer = 0
var Invincibility = 0

var Ocupied = 0
var isfalling = 0

var isWallSliding = 0
var isLeftWallSliding = false
var isRightWallSliding = false
var isClutchHang = 0
var debug
signal FokusUse
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#When needed create variable for Animation Player for Animation cutting
@onready var anim = get_node("AnimationPlayer")
@onready var head = get_node("Sprite/head/Area2D")
@onready var shoulder = get_node("Sprite/Torso/Area2D")
@onready var ThisTileMap = get_node("../../TileMap/TileMap")

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
	
	if Stamina < maxtStamina and staminaRegTimer <= 0:
		Stamina = min(maxtStamina, Stamina + 5*delta)
		

	#fallspeed calculation for falldamage
	if is_on_floor() && isfalling > 900:
		Health -= isfalling*0.05
		if is_on_floor() && isfalling > 1500:
			Health -= isfalling*0.1
	if isWallSliding == 1 && isfalling > 900:
		Health -= isfalling*0.05
	isfalling = velocity.y

	
	# Check for wall sliding
	isWallSliding = max(isWallSliding - delta, 0)
	if not is_on_wall():
		isWallSliding = 0
		isClutchHang = 0
	if (isWallSliding == 0 && isClutchHang == 0):
			isLeftWallSliding = false
			isRightWallSliding = false
			
			
	# Add the gravity.
	if not is_on_floor():
		if isWallSliding > 0 and velocity.y >= 0:
			velocity.y = min(velocity.y + gravity * delta / 2, SPEED / 4)
		elif (isClutchHang == 1):
			velocity.y = 0
			isClutchHang = 0
		else:
			velocity.y += gravity * delta
			
			

	if is_on_wall_only():
		if Stamina > 0 && Ocupied <= 0:
			if head._overlapping.has(ThisTileMap):
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
			elif shoulder._overlapping.has(ThisTileMap):
				if Input.is_action_pressed("Left"):
					isClutchHang = 1
					Stamina -= delta * 1
					anim.play("Clutch")
					isLeftWallSliding = true
				elif Input.is_action_pressed("Right"):
					isClutchHang = 1
					Stamina -= delta * 1
					anim.play("Clutch")
					isRightWallSliding = true
	else:
		isWallSliding = 0
		isClutchHang = 0
	if (isWallSliding == 0 && isClutchHang == 0):
			isLeftWallSliding = false
			isRightWallSliding = false


	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor() && Ocupied <= 0:
			if Stamina > 0:
				anim.play("Jump")
				Stamina -= 2
				velocity.y = JUMP_VELOCITY
		elif isLeftWallSliding:
			if Stamina > 0:
				anim.play("Jump")
				if not isClutchHang:
					Stamina -= 3
				velocity.x = SPEED * 7 / 10
				velocity.y = JUMP_VELOCITY * 8 / 10
				if isClutchHang:
					Stamina -= 2
					velocity.x = SPEED * 4 / 10
					velocity.y = JUMP_VELOCITY * 8 / 10
		elif isRightWallSliding:
			if Stamina > 0:
				anim.play("Jump")
				if not isClutchHang:
					Stamina -= 3
				velocity.x = -SPEED * 7 / 10
				velocity.y = JUMP_VELOCITY * 8 / 10
				if isClutchHang:
					Stamina -= 2
					velocity.x = -SPEED * 4 / 10
					velocity.y = JUMP_VELOCITY * 8 / 10
		
	

	
	
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if Input.is_action_pressed("Right")  && Ocupied == 0:
		if is_on_floor():
			velocity.x = min(velocity.x + SPEED * delta * 4, SPEED)
		else:
				velocity.x = min(velocity.x + SPEED * delta * 2.7, SPEED)
		get_node("Sprite").scale.x= 1
		get_node("Sprite").position.x= 1.5
		if velocity.y == 0 && isClutchHang == 0:
			anim.play("Move")
	elif Input.is_action_pressed("Left") && Ocupied == 0:
		if is_on_floor():
				velocity.x = max(velocity.x - SPEED * delta * 4, -SPEED)
		else:
				velocity.x = max(velocity.x - SPEED * delta * 2.7, -SPEED)
		get_node("Sprite").scale.x= -1
		get_node("Sprite").position.x= -2.5
		if velocity.y == 0 && isClutchHang == 0:
			anim.play("Move")



		
	elif is_on_floor():
		if not HurtTimer > 0 && Ocupied == 0:
			velocity.x = lerp(velocity.x, 0., 0.2)
		if velocity.y == 0 && Ocupied <= 0:
			
			
			anim.play("Idle")
		
	if velocity.y > 0 and isWallSliding <= 0 && Ocupied <= 0:
		anim.play("Fall")
		
	move_and_slide()
	
	








func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fallthroughclutch":
		Ocupied = 0
