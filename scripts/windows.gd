extends Sprite2D  # Inherit from Sprite2D to match the node type

@onready var start_menu_scene = preload("res://scenes/start_menu.tscn")  # Use the correct path to the .tscn file
@onready var area2d = $"../Area2D"  # Adjusted the path to the Area2D node
var start_menu_instance: Node = null
var player_near = false

func _ready():
	if area2d:
		area2d.connect("body_entered", Callable(self, "_on_body_entered"))
		area2d.connect("body_exited", Callable(self, "_on_body_exited"))
	else:
		print("Error: Area2D node not found!")

func _process(_delta):
	if player_near and Input.is_action_just_pressed("ui_accept"):  # Detect "E" key
		if start_menu_instance == null:
			# If start menu is not loaded, instance it
			start_menu_instance = start_menu_scene.instance()
			get_tree().root.add_child(start_menu_instance)  # Add it to the root or appropriate parent node
		else:
			# Toggle visibility of the Start Menu
			start_menu_instance.visible = !start_menu_instance.visible

func _on_body_entered(body):
	if body.name == "Player":
		player_near = true

func _on_body_exited(body):
	if body.name == "Player":
		player_near = false
