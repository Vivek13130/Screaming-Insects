extends Control
@onready var fps_label: Label = $VBoxContainer/fpsLabel
@onready var agent_count_label: Label = $VBoxContainer/AgentCountLabel
@onready var scream_calls: Label = $VBoxContainer/screamCalls


func _process(delta: float) -> void:
	fps_label.text = "FPS : " + str(Engine.get_frames_per_second())
	agent_count_label.text = "Total Agents : " + str(Manager.total_agents_live)
	scream_calls.text = "Max Screams in a frame: " + str(Manager.max_scream_calls)
