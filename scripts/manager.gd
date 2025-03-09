extends Node


# making a grid  : 
const grid_cell_size = 50 # 20 x 20 
var agents_grid : Dictionary = {}

var total_agents_live : int = 0
var total_screams : int = 0 

# agent color based on target : 
const target_is_food_color : Color = Color.GREEN
const target_is_home_color : Color = Color.BLUE

const interaction_color_from_home_base : Color = Color.BLUE
const interaction_color_from_food_base : Color = Color.GREEN


# agent speed limits 
const min_speed : int = 1 
const max_speed : int = 5

# agent scream distance 
const scream_distance = 1 # means 2 rectangular rings around this agent in a grid  
var max_scream_calls = 0 # in a frame 

var show_grid = false
var show_interaction_lines = false

var screen_size 

var interaction_lines_home_base = []
var interaction_lines_food_base = []

func _ready() -> void:
	screen_size = get_viewport().get_visible_rect().size

#
#func get_grid_cell_key(position: Vector2) -> Vector2:
	#return Vector2i(int(position.x / grid_cell_size), int(position.y / grid_cell_size))

func get_grid_cell_key(position: Vector2) -> Vector2i:
	return Vector2i(floor((position.x + 0.01) / grid_cell_size), floor((position.y + 0.01) / grid_cell_size))

func _process(delta: float) -> void:
	max_scream_calls = max(max_scream_calls , total_screams)
	total_screams = 0 
