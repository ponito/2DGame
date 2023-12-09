extends CharacterBody2D
var player
var chase = false
var SPEED = 200
var JumpTimer = 40
var JumpTimerBase = 100
var JumpVelocity= -300
var Health = 100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	$HealthBar.value = Health
	
func _process(delta):
	$HealthBar.value = Health
	
	if Health <= 0:
		self.queue_free()
	

func _physics_process(delta):
	#Gravity for the Enemy
	velocity.y += gravity * delta	
	
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0., 0.2)
	
	#Internal Timer
	if JumpTimer > 0:
		JumpTimer = JumpTimer -1
	else:
		if chase == true:
			player = get_node("../../player/player")
			var direction = (player.position - self.position).normalized()
			jump(direction)
		JumpTimer = JumpTimerBase
	
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
			var direction = (player.position - self.position).normalized()
			body.velocity.x = sign(direction.x) * 500
			velocity.x -= sign(direction.x) * 200
			body.Health -= 4
		
