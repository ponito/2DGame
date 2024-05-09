extends CharacterBody2D
@onready var player = get_node("../../player/player")
@onready var anim = get_node("CollisionShape2D/AnimatedSprite2D")
@onready var body = get_node("CollisionShape2D")
var chase = false
var SPEED = 100
var HyperArmor = 100
var JumpTimer = 40
var JumpTimerBase = 10
var JumpVelocity= -400
var KnockBackResist = 5
var Health = 200:
	get:
		return Health
	set(value):
		if (0 >= value):
			self.queue_free()
		if (Health - value >= 10):
			HurtTimer = 5
			if (Health - value >= 40):
				HurtTimer = 10
			pass
		Health = value


var HurtTimer = 0
var direction
var Ocupied = 0
var playerMeele = false





signal ArmAttack



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	$HealthBar.value = Health
	
func _process(_delta):
	$HealthBar.value = Health
	


func _physics_process(delta):
	if Ocupied < 0:
		Ocupied = min(0, Ocupied + delta) 
	
	
	
	#Gravity for the Enemy
	velocity.y += gravity*2 * delta
	if is_on_floor():
		velocity.x = lerp(velocity.x, 0., 0.2)
		
	#Stuncountdown after being Damaged
	if HurtTimer > 0:
		HurtTimer = max(0, HurtTimer - delta*10)
	
	#Internal Timer
	if  is_on_floor() && HurtTimer <= 0 && Ocupied == 0:
		var direction = (player.position - self.position).normalized()
		if chase == true and not playerMeele == true:
			if velocity.x > 5 or velocity.x < -5:
				if anim.animation == "idle":
					anim.stop()
				anim.play("walk")
			else:
				if anim.animation == "walk":
					anim.stop()
					anim.play("idle")
				pass
				
			velocity.x = sign(direction.x) * SPEED
			if velocity.x > 0:
				body.scale.x = -1
			else:
				body.scale.x = 1
		elif playerMeele == true:
			if direction.x > 0:
				body.scale.x = -1
			emit_signal("ArmAttack")
	
	
	
	if HurtTimer > 0:
		anim.stop()
	
	move_and_slide()



#When Player/Smth enters Vision
func _on_enemy_vision_body_entered(body):
	if body.name == "player":
		chase = true
		
#When Player/Smth leaves Vision
func _on_enemy_vision_body_exited(body):
	if body.name == "player":
		chase = false
		anim.stop()






func _on_animated_sprite_2d_animation_finished():
	if velocity.x > 1 or velocity.x < -1 and Ocupied == 0:
		##emit_signal("ArmAttack")
		pass
	else:
		anim.stop()
		anim.play("idle")
	pass # Replace with function body.






func _on_enemy_meele_body_entered(body):
	if body.name == "player":
		playerMeele = true
	pass # Replace with function body.


func _on_enemy_meele_body_exited(body):
	if body.name == "player":
		playerMeele = false
	pass # Replace with function body.
