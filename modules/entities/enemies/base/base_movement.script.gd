extends CharacterBody2D

@onready var raycast_right: RayCast2D = $RaycastRight
@onready var raycast_left: RayCast2D = $RaycastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 60.0
var direction = 1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if direction:
		velocity.x += direction * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x,0,SPEED)
		
	if raycast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	
	if raycast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	
	move_and_slide()


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.onDeath()
