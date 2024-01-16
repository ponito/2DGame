extends CharacterBody2D
var LifeTime = 40
var speed = 600
var EnemyHyperArmor = 0

var direction = 0

@onready var player = get_node("../player/player")




func _ready():
	#Setzt direction zu dem Vector aus der Spielerposition und der Maus position
	direction = (get_global_mouse_position() - self.global_position).normalized()

	
	self.rotation = (direction.angle())
	





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#Setzt velocity zu direction
	velocity = direction * speed 
	
	
	
	
	
	
	
	if LifeTime >= 0:
		LifeTime -= delta*10
	else:
		self.queue_free()
	
	
	
	
	
	
	
	
	move_and_slide()


func _on_area_2d_body_entered(body):
	var direction = (body.position - self.position).normalized()
	body.position.y += -5
	body.velocity.y = sign(direction.y) * 0.1 -100
	body.velocity.x = sign(direction.x) * 300 * 1
	if "HyperArmor" in body:
		EnemyHyperArmor = EnemyHyperArmor + body.HyperArmor
	else:
		pass
	body.Health -= 20
	self.queue_free()
	#body.velocity.x += sign(direction.x) * 500

