extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@onready var hit_sound: AudioStreamPlayer2D = $HitSound
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const KNOCKBACK_FORCE = 150.0

enum State {IDLE, RUNNING, JUMPING,FALLING, DEAD}
var currentState = State.IDLE


func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	
	if currentState == State.DEAD:
		velocity *= 0.98  # Adjust this value to control how quickly knockback slows down
		move_and_slide()
		return
	
	# mount the gravity
	applyGravity(delta)

	var mouse_pos = get_global_mouse_position(); 
	var direction = (mouse_pos - global_position).normalized()
	
	currentState = State.IDLE if is_on_floor() else State.JUMPING if velocity.y < 0 else State.FALLING
	
	handleJump(JUMP_VELOCITY)
	handleMovement(direction,delta)

	move_and_slide()
	animation_player.play_animation(currentState)
	
	
func applyGravity(delta:float):
	if not is_on_floor():
		velocity += get_gravity() * delta

func handleJump(force):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		currentState = State.JUMPING
		jump_sound.play()
		velocity.y = force

func handleMovement(direction:Vector2,delta:float):
	animation_player.flipSprite(direction)
	
	if Input.is_action_pressed("move_right"):
		currentState = State.RUNNING
		velocity.x = direction.x * SPEED
		
	elif is_on_floor() :
		currentState = State.IDLE;
		velocity.x = 0


func onDeath(collision_source:Vector2 = Vector2.ZERO):
	if currentState != State.DEAD:
		currentState = State.DEAD
		
		 # Apply knockback
		if collision_source != Vector2.ZERO:
			var knockback_direction = (global_position - collision_source).normalized()
			velocity = knockback_direction * KNOCKBACK_FORCE
		else:
			velocity = Vector2.ZERO  # If no collision source, just stop movemen
			
		hit_sound.play()
		animation_player.play_death_animation()
