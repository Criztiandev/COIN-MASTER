extends AnimatableBody2D

@onready var player: CharacterBody2D = %Player
var is_player_on_platform = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_on_platform = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		is_player_on_platform = false

func _process(delta: float) -> void:
	if is_player_on_platform and Input.is_action_pressed("move_down"):
		player.position.y += 1
