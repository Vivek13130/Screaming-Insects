extends Control
@onready var fps_label: Label = $VBoxContainer/fpsLabel
@onready var agent_count_label: Label = $VBoxContainer/AgentCountLabel
@onready var scream_calls: Label = $VBoxContainer/screamCalls
@onready var show_grid: CheckBox = $VBoxContainer/showGrid
@onready var show_interaction_lines: CheckBox = $VBoxContainer/showInteractionLines

func _ready() -> void:
	Manager.show_grid = show_grid.button_pressed
	Manager.show_interaction_lines = show_interaction_lines.button_pressed

func _process(delta: float) -> void:
	fps_label.text = "FPS : " + str(Engine.get_frames_per_second())
	agent_count_label.text = "Total Agents : " + str(Manager.total_agents_live)
	scream_calls.text = "Max Screams in a frame: " + str(Manager.max_scream_calls)


func _on_show_grid_pressed() -> void:
	Manager.show_grid = !Manager.show_grid


func _on_show_interaction_lines_pressed() -> void:
	Manager.show_interaction_lines = ! Manager.show_interaction_lines
