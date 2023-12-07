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



func _physics_process(delta):
	#Gravity for the Enemy
	velocity.y += gravity * delta
	
	#Internal Timer
	if JumpTimer > 0:
		JumpTimer = JumpTimer -1
	else:
		if chase == true:
			velocity.y = JumpVelocity
		JumpTimer = JumpTimerBase
	
	#Enemy Movement when Player Visible
	if chase == true:
		player = get_node("../../player/player")
		var direction = (player.position - self.position).normalized()
		if not is_on_floor():
			pass
			velocity.x = direction.x * SPEED
			if velocity.x > 0:
				get_node("AnimatedSprite2D").flip_h = false
			else:
				get_node("AnimatedSprite2D").flip_h = true
		else:
			velocity.x = 0
	move_and_slide()



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
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			body.velocity.x += +800
		else:
			body.velocity.x += -800
		body.Health -= 1
