extends Node


func _change_scene(next_scene_path: String):
	var _next_scene_path: String = next_scene_path
	
	if ResourceLoader.exists(_next_scene_path):
		var _scene_to_load: PackedScene = load(_next_scene_path)

		get_tree().call_deferred(
		"change_scene_to_packed", _scene_to_load)
	else:
		print_debug("Scene does not exist or path is incorrect.")
