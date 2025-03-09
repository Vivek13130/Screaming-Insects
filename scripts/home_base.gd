extends Node2D
const base_name = "home"

func _ready() -> void:
	place_base_in_center_of_grid()

var grid_cell_key : Vector2i

func place_base_in_center_of_grid():
	grid_cell_key = Manager.get_grid_cell_key(global_position)  # Get the grid cell based on the current position
	var cell_size = Manager.grid_cell_size  # Assuming you have a cell size defined in Manager
	
	print("grid key for food base : ", grid_cell_key)

	# Calculate the center of the grid cell
	var cell_center_position = Vector2(grid_cell_key.x * cell_size, grid_cell_key.y * cell_size) + Vector2(cell_size / 2, cell_size / 2)
	# Update the food base position
	global_position = cell_center_position
	Manager.agents_grid[grid_cell_key] = []

func _process(delta: float) -> void:
	if !Manager.agents_grid.has(grid_cell_key):
		Manager.agents_grid[grid_cell_key] = []
	
	if(Manager.agents_grid[grid_cell_key].size() > 0 ): 
		#print("agents in food base : " , Manager.agents_grid[grid_cell_key].size())
		for agent in Manager.agents_grid[grid_cell_key] : 
			agent.update_from_base(base_name)
