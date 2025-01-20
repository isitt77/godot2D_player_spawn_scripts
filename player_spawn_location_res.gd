class_name PlayerSpawnLocationRes
extends Resource

# Player spawn location
@export var _initial_spawn_position: Vector2

# Player spawn direction facing (Need default value for main scene)
@export_enum("down", "up", "left", "right") 
var _initial_player_direction: String = "down"


# Get Player position from EnterExit script.
func get_initial_player_position(initial_spawn_position: Vector2):
	_initial_spawn_position = initial_spawn_position
	return _initial_spawn_position

# Pass stored Player position into Player script.
func  set_initial_player_position():
	return _initial_spawn_position

# Get AnimatonPlayer velocity from EnterExit script.
func get_last_anim_player_direction(initial_player_direction: String):
	_initial_player_direction = initial_player_direction
	
# Pass stored AnimatonPlayer velocity into Player _ready().
func set_new_player_anim_direction():
	return _initial_player_direction
