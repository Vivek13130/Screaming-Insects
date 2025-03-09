extends Node2D

@export var show_grid : bool = false 
@export var show_interaction_lines : bool = true

func _process(delta: float) -> void:
		update_canvas()
	
	
# it will show various interactions between agents 
func update_canvas():
	queue_redraw()

var should_clear_home_interaction : bool = false
var should_clear_food_interaction : bool = false

#var max_interaction_lines = 40

func _draw() -> void:
	
	if show_interaction_lines : 
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
	
	if show_grid : 
		for x in range(0, Manager.screen_size.x , Manager.grid_cell_size):
			draw_line(Vector2(x, 0) , Vector2(x, Manager.screen_size.y), Color(1,1,0,0.1), 2, false)
		
		for y in range(0, Manager.screen_size.y , Manager.grid_cell_size):
			draw_line(Vector2(0, y) , Vector2(Manager.screen_size.x, y),  Color(1,1,0,0.1), 2, false)

	
	
