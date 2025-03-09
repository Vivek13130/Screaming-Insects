extends Node

var total_agents_live : int = 0

var agents = [] 
var total_screams : int = 0 

# agent color based on target : 
var target_is_food_color : Color = Color.GREEN
var target_is_home_color : Color = Color.BLUE

var interaction_color_from_home_base : Color = Color.BLUE
var interaction_color_from_food_base : Color = Color.GREEN


# agent speed limits 
var min_speed : int = 1 
var max_speed : int = 5

# agent scream distance 
var scream_distance = 100 
var max_scream_calls = 0 # in a frame 

var screen_size 

var interaction_lines_home_base = []
var interaction_lines_food_base = []

func _ready() -> void:
	screen_size = get_viewport().get_visible_rect().size

var interaction_manager : Node2D = preload("res://scenes/interaction_manager.tscn").instantiate()
var show_interactions : bool = false 
