extends AnimationPlayer

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"


func _ready() -> void:
	if not animated_sprite_2d:
		push_error("Animated Sprite Not Found")

func play_animation(state):
	if not animated_sprite_2d:
		return
	match state:
		0:
			animated_sprite_2d.play("idle")
		1:
			animated_sprite_2d.play("run")
		2:
			animated_sprite_2d.play("jump")
		4:
			animated_sprite_2d.play("death")
		pass

func play_death_animation() -> void:
	if animated_sprite_2d.sprite_frames.has_animation("death"):
		animated_sprite_2d.play("death")
	else:
		push_error("Errr: Death Animation not found")

func flipSprite(direction:Vector2):
	animated_sprite_2d.flip_h = direction.x < 0;
