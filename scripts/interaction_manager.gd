extends Node2D


func _process(delta: float) -> void:
	if Manager.show_interactions : 
		update_canvas()
	
	
# it will show various interactions between agents 
func update_canvas():
	queue_redraw()

var should_clear_home_interaction : bool = false
var should_clear_food_interaction : bool = false

func _draw() -> void:
	
	for pair in Manager.interaction_lines_food_base:
		draw_line(pair[0], pair[1], Manager.interaction_color_from_food_base, 2)
		should_clear_food_interaction = true
		
	for pair in Manager.interaction_lines_home_base:
		draw_line(pair[0] , pair[1] , Manager.interaction_color_from_home_base , 2)
		should_clear_home_interaction = true 
	
	if(should_clear_home_interaction):
		Manager.interaction_lines_home_base.clear()
		should_clear_home_interaction = false 
		
	if(should_clear_food_interaction):
		Manager.interaction_lines_food_base.clear()
		should_clear_food_interaction = false
		
	
	
