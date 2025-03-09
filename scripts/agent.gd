extends Node2D

var counters : Vector2  
var target_destination : String = "food"   #either "food" or "home"

# two counters  : 1st for home , 2nd for food. 
# counter is a estimation of steps to base 
# 1st counter shows roughly this much steps are need to reach home 
# same for the 2nd one 

var direction : Vector2 
var move_speed : int # random speed for each agent in the range 5 to 15


@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	# setting the initials 
	direction = Vector2(randf() , randf()).normalized() # assigning initial random direction 
	counters = Vector2.ZERO
	move_speed = randi_range(Manager.min_speed , Manager.max_speed) * 20
	if(randf() > 0.5):
		target_destination = "food"
		sprite.modulate = Manager.target_is_food_color
	else:
		target_destination = "home"
		sprite.modulate = Manager.target_is_home_color
	

func _process(delta: float) -> void:
	move_randomly(delta)
	keep_agents_inside_screen() 
	Manager.max_scream_calls = max(Manager.max_scream_calls , Manager.total_screams)
	Manager.total_screams = 0 

func move_randomly(delta : float) -> void : 
	
	position += direction * move_speed * delta 
	
	# increase each counter on every movement step 
	counters.x += 1
	counters.y += 1
	
	var angle_shift = randf_range(-0.1 , 0.1)
	direction = direction.rotated(angle_shift).normalized()

func keep_agents_inside_screen(): # keep the agents inside the screen bounds 
	# Reverse direction on hitting screen boundaries
	if position.x < 0 or position.x > Manager.screen_size.x:
		direction.x = -direction.x

	if position.y < 0 or position.y > Manager.screen_size.y:
		direction.y = -direction.y


func scream():
#	send scream request to others : 
# only call this function when any counter is updated 
	Manager.total_screams += 1
	
	for agent in Manager.agents:
		if(global_position.distance_to(agent.global_position) <= Manager.scream_distance):
			agent.update_from_scream(counters + Vector2(Manager.scream_distance , Manager.scream_distance), global_position)

func update_from_scream(screamer_counters : Vector2, screamer_position : Vector2):
	#print("heard a scream")
	# we have to compare these counters with ours : 
	var should_update_direction : bool = false 
	# we will only update direction when the counter related to target destination is updated
	
	var should_scream_again : bool = false
	# if any counter is updated , we will scream again.
	
	var interaction_base : String = "None"
	
	if(screamer_counters.x < counters.x): # home counters
		counters.x = screamer_counters.x 
		should_scream_again = true 
		if(target_destination == "home"):
			should_update_direction = true
			interaction_base = "home"
	
	if(screamer_counters.y < counters.y): # food counter 
		counters.y = screamer_counters.y
		should_scream_again = true
		if(target_destination == "food"):
			should_update_direction = true 
			interaction_base = "food"
	
	if(should_update_direction):
		direction = Vector2(screamer_position - global_position).normalized()
	
	# if any counter is updated we will scream again.
	# so to show that counter update we will draw a line in between both screamer and current agent 
	
	if(should_update_direction):
		# showing interaction lines between these two 
		var new_interaction = []
		new_interaction.append(screamer_position)
		new_interaction.append(global_position)
		
		if(interaction_base == "food"):
			Manager.interaction_lines_food_base.append(new_interaction)
		elif(interaction_base == "home"):
			Manager.interaction_lines_home_base.append(new_interaction)
		
	
	if(should_scream_again):
		call_deferred("scream")


func update_from_base(base_name : String):
	# it will be called by a base whenever this agent collides into a base 
	#print("updating")
	
	if(base_name == "home" && target_destination == "home"):
		# means we were heading home and collided into food base
		counters.x = 0 # setting the home counter to be zero 
		target_destination = "food"
		sprite.modulate = Manager.target_is_food_color
		direction = direction.rotated(PI) # rotating the direction by 180
		scream()
		# because counters are updated 
	
	if(base_name == "food" and target_destination == "food"):
		# means we were heading for food and collided into food base 
		counters.y = 0 # setting the food counter = 0 
		target_destination = "home"
		sprite.modulate = Manager.target_is_home_color
		direction = direction.rotated(PI) # rotating the direction by 180
		scream()
