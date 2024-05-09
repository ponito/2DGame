extends CharacterBody2D
var player
var chase = false
var SPEED = 300
var JumpTimer = 40
var JumpTimerBase = 10
var JumpVelocity= -400
var Health = 100:
	get:
		return Health
	set(value):
		if (0 >= value):
			self.queue_free()
		if (Health - value >= 10):
			HurtTimer = 2
			if (Health - value >= 40):
				HurtTimer = 4
			pass
		Health = value


var HurtTimer = 0
var direction
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	$HealthBar.value = Health
	
func _process(_delta):
	$HealthBar.value = Health
	


func _physics_process(delta):
	
	#slime bounce of walls
	if is_on_wall():
		if get_node("AnimatedSprite2D").flip_h == false:
			velocity.x = velocity.x - SPEED
		else:
			velocity.x = velocity.x + SPEED
			pass
	#Gravity for the Enemy
	velocity.y += gravity * delta	
	
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0., 0.2)
		
	#Stuncountdown after being Damaged
	if HurtTimer > 0:
		HurtTimer = max(0, HurtTimer - delta*10)
	
	#Internal Timer
	if  is_on_floor() && HurtTimer <= 0:
		if JumpTimer > 0:
			JumpTimer = max(0, JumpTimer - delta*100)
		else:
			if chase == true:
				player = get_node("../../player/player")
				var direction = (player.position - self.position).normalized()
				jump(direction)
			JumpTimer = JumpTimerBase
			JumpTimer += RandomNumberGenerator.new().randi_range(10, 200)

	move_and_slide()


func jump(direction):
	velocity.y = JumpVelocity
	velocity.x = RandomNumberGenerator.new().randf_range(0.6, 1.4) * sign(direction.x) * SPEED
	if velocity.x > 0:
		get_node("AnimatedSprite2D").flip_h = false
	else:
		get_node("AnimatedSprite2D").flip_h = true


#When Player/Smth enters Vision
func _on_enemy_vision_body_entered(body):
	if body.name == "player":
		chase = true
		
#When Player/Smth leaves Vision
func _on_enemy_vision_body_exited(body):
	if body.name == "player":
		chase = false

#Damage Zone
func _on_hitbox_body_entered(body):
	if body.name == "player":
		if body.Invincibility == 0:
			body.HurtTimer = 0.2
			body.Invincibility = 0.5
			direction = 0
			direction = (player.position - self.position).normalized()
			body.velocity.x = sign(direction.x) * 1000
			velocity.x -= sign(direction.x) * 400
			body.Health -= 40
		
