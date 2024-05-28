extends Node3D

@onready var _camera := $MainCamera as Camera3D
@onready var _player := $Player as CharacterBody3D

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		$Player/Knight/AnimationPlayer.play("Walking_A")
		var mouse_cursor_position = event.position
		var camera_ray_length := 1000.0
		var camera_ray_start := _camera.project_ray_origin(mouse_cursor_position)
		var camera_ray_end := camera_ray_start + _camera.project_ray_normal(mouse_cursor_position) * camera_ray_length

		var closest_point_on_navmesh := NavigationServer3D.map_get_closest_point_to_segment(
			get_world_3d().navigation_map,
			camera_ray_start,
			camera_ray_end
			)
		_player.set_target_position(closest_point_on_navmesh)
