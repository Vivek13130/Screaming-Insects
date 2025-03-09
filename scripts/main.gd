extends Node2D
@onready var agent_manager: Node2D = $AgentManager
var agent_scene : PackedScene = preload("res://scenes/agent.tscn")

func _ready() -> void:
	get_viewport().connect("size_changed", Callable(self, "_on_viewport_size_changed"))

func _on_viewport_size_changed() -> void:
	Manager.screen_size = get_viewport().get_visible_rect().size


func _process(_delta: float) -> void:
	
	if(Input.is_action_just_pressed("restart")):
		get_tree().reload_current_scene()

	
	if(Input.is_action_pressed("Spawn_Agents")):
		var new_agent = agent_scene.instantiate()
		new_agent.global_position = get_global_mouse_position()
		agent_manager.add_child(new_agent)
		Manager.total_agents_live += 1
		
		# adding the agent in grid : 
		var cell_key = Manager.get_grid_cell_key(new_agent.global_position)
		if(! Manager.agents_grid.has(cell_key)):
			Manager.agents_grid[cell_key] = []
		Manager.agents_grid[cell_key].append(new_agent)
		
