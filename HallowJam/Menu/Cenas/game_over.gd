extends MarginContainer

const menuScene = "res://Menu/Cenas/main_menu.tscn"
const startScene = "res://Cenas/Intro/intro.tscn"

@onready var selectorOne = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Label
@onready var selectorTwo = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Label


var currentSelection = 0

func setCurrentSelection(currentSelection) :
	selectorOne.text = ""
	selectorTwo.text = ""	
	if currentSelection == 0 :
		selectorOne.text = ">"
	else :
		selectorTwo.text = ">"

func handleSelection(currentSelection) :
	if(currentSelection == 0) :
		get_tree().change_scene_to_file(startScene)			
	else :
		get_tree().change_scene_to_file(menuScene)			
		
# Called when the node enters the scene tree for the first time.
func _ready():
	setCurrentSelection(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("ui_down")) :
		if(currentSelection < 1) :
			currentSelection += 1		
			setCurrentSelection(currentSelection)
		else :
			currentSelection = 0
			setCurrentSelection(currentSelection)
	elif(Input.is_action_just_pressed("ui_up")) :
		if(currentSelection > 0) :
			currentSelection -= 1
			setCurrentSelection(currentSelection)
		else :
			currentSelection = 2
			setCurrentSelection(currentSelection)
	
	if(Input.is_action_just_pressed("ui_accept")) :
		handleSelection(currentSelection)
