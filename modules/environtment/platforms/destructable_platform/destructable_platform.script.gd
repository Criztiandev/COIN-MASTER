extends AnimatableBody2D

@onready var player: CharacterBody2D = %Player
@onready var timer: Timer = $Timer


func _ready() -> void:
	if not player:
		print("There is no player availalble")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		timer.start()

func _on_timer_timeout() -> void:
	queue_free()
