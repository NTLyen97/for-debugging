extends Control

#region Variables and Onready
#Token display
@onready var player_pause_display: Control = $"."

#Preloading Displays...
@onready var player_stats_scene = $player_stats
#@onready var player_map_scene = $player_map
@onready var player_inventory_scene = $player_inventory_disp
#@onready var player_database_scene = $player_database
@onready var player_cards_scene = $player_cards
#endregion

#var old_max_hp: float
#var new_max_hp = PlayerData.final_stat("max_hp") #HP after upgrade
#var hp_diff = new_max_hp - old_max_hp #Take difference
#PlayerData.current_hp += hp_diff #Add diff to current HP
#PlayerData.current_hp = clamp(PlayerData.current_hp, 0, new_max_hp) #Clamp so that HP isn't below 0

#Function for the inventory button
#Makes it so that pressing "I" then pressing "I" again pauses/unpauses the game.
func _input(event) -> void: 
	if event.is_action_pressed("open_inventory"): #Checks for event
		if player_pause_display.visible == false: #Checks if player_pause is currently showing
			print("Show inventory") #Debug statement
			player_pause_display.show() #Shows pause display
			get_tree().paused = true #Pauses the game
			EventBus.stat_overview.emit() #Updates player stats
			EventBus.paused.emit()
		else:
			print("Hide inventory") #Debug statement
			player_pause_display.hide() #Hides pause display
			get_tree().paused = false #Unpauses the game
			EventBus.unpaused.emit()

func _ready():
	#Connecting signals...
	#EventBus.connect("tokens_changed", Callable(self, "_on_tokens_changed")) #For updating token count
	EventBus.connect("change_to_stat", Callable(self, "_on_stat_overview_pressed"))
	EventBus.connect("change_to_inv", Callable(self, "_on_inventory_display_pressed"))
	EventBus.connect("change_to_card", Callable(self, "_on_card_display_pressed"))
	
	#inv_pos_x = inventory_display.position.x
	#inv_pos_y = inventory_display.position.y
	#
	#card_pos_x = card_display.position.x
	#card_pos_y = card_display.position.y
	hide_all_scenes() #Hide all scenes
	player_stats_scene.show() #Show just this scene
	#_on_tokens_changed() #Signal connection
	
#Function for refreshing token cost changes
#func _on_tokens_changed():
	#str_token_display.update_count(PlayerData.player_stat_tokens["strength_token"]) #Displays strength tokens
	#tank_token_display.update_count(PlayerData.player_stat_tokens["tank_token"]) #Displays tank tokens
	#speed_token_display.update_count(PlayerData.player_stat_tokens["speed_token"]) #Displays speed tokens
	
#Hides all scenes so they don't overlap
func hide_all_scenes():
	player_stats_scene.hide()
	#player_map_scene.hide()
	player_inventory_scene.hide()
	#player_database_scene.hide()
	player_cards_scene.hide()
	
#region Button pressing functions
func _on_stat_overview_pressed() -> void: #Shows player_stat_scene
	hide_all_scenes()
	player_stats_scene.show()
	EventBus.stat_overview.emit()

func _on_inventory_display_pressed() -> void: #Show inventory scene
	hide_all_scenes()
	player_inventory_scene.show()
	EventBus.inventory_display.emit()

func _on_card_display_pressed() -> void: #Show card scene
	hide_all_scenes()
	player_cards_scene.show()
	EventBus.card_display.emit()

#endregion
