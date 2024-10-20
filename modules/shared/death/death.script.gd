extends Area2D

@onready var player: CharacterBody2D = %Player
@onready var timer: Timer = $Timer
@onready var player_hit: AudioStreamPlayer2D = $PlayerHit


func _ready() -> void:
	if not player:
		push_error("There is no player prefab exist")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		playerDeath(body)

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene(); 


func playerDeath(hit: Node2D) -> void:
	Engine.time_scale = 0.5
	hit.onDeath(global_position);
	timer.start()
