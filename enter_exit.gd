class_name EnterExit 

extends Area2D

# Scene (level) that will be loaded in SceneManager
@export_file("*.tscn") var _scene_to_load: String

# Player spawn position for next scene.
@export var _player_next_position: Vector2

# Player animation direction to face in next scene.
var _player_next_direction: String

# Custom Resource to store and pass Player data to next scene.
@export var player_spawn_res: PlayerSpawnLocationRes


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		
		# Get Player position for next scene
		player_spawn_res.get_initial_player_position(
			_player_next_position)
			
		# Current Player animation to be passed to PlayerSpawnLocationRes
		var _current_animation: StringName = (
			body._animated_sprite_2d.animation)
			
		var _trimmed_prefix: String
		
		if _current_animation.begins_with("walk_"):
			_trimmed_prefix = _current_animation.trim_prefix("walk_")
		else:
			_trimmed_prefix = _current_animation.trim_prefix("idle_")
			
		_player_next_direction = _trimmed_prefix
		
		player_spawn_res.get_last_anim_player_direction(
			_player_next_direction)
		
		# Load destination scene (level)
		if _scene_to_load != "":
			SceneManager._change_scene(_scene_to_load)
		else:
			print_debug("Need a scene to load in this EnterExit.")
