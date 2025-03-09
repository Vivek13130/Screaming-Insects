extends Node2D
const base_name = "home"


func _on_home_base_area_entered(area: Area2D) -> void:
	area.get_parent().update_from_base(base_name)
