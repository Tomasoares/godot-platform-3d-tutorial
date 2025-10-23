class_name CameraController
extends Node
	
func handle_camera(delta: float) -> void:
	$AutomaticCamera.handle_camera(delta)
	$ManualCamera.handle_camera(delta)
	$FollowPlayer.follow()
