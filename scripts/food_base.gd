extends Node2D

const base_name = "food"

func _on_food_base_area_entered(area: Area2D) -> void:
	area.get_parent().update_from_base(base_name)
