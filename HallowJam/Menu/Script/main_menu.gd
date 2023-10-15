extends MarginContainer

const startScene = "res://Cenas/Intro/intro.tscn"



@onready var textOne = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Option
@onready var textTwo = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Option
@onready var textThree = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Option

const originalFontColor = Color(0.757, 0.737, 0.329)
const originalShadowColor = Color(0.627, 0.506, 0.169)
const selectedFontColor = Color(0.29, 0.435, 0.459)
const selectedShadowColor = Color(0.2, 0.271, 0.373)

@onready var selectorOne = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
@onready var selectorTwo = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
@onready var selectorThree = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector

var currentSelection = 0

func changeColor(component,fontColor, shadowColor) :
	component.add_theme_color_override("font_color",fontColor)
	component.add_theme_color_override("font_shadow_color",shadowColor)

func setCurrentSelection(currentSelection) :	
	selectorOne.text = ""
	selectorTwo.text = ""
	selectorThree.text = ""
	changeColor(textOne,originalFontColor,originalShadowColor)
	changeColor(textTwo,originalFontColor,originalShadowColor)
	changeColor(textThree,originalFontColor,originalShadowColor)
	if currentSelection == 0 :
		selectorOne.text = ">"
		changeColor(textOne,selectedFontColor,selectedShadowColor)
	elif currentSelection == 1 :
		selectorTwo.text = ">"		
		changeColor(textTwo,selectedFontColor,selectedShadowColor)
	else :
		selectorThree.text = ">"			
		changeColor(textThree,selectedFontColor,selectedShadowColor)

func handleSelection(currentSelection) :
	if(currentSelection == 0) :
		get_tree().change_scene_to_file(startScene)			
	elif(currentSelection == 2) :
		get_tree().quit()
		
# Called when the node enters the scene tree for the first time.
func _ready():
	changeColor(selectorOne,selectedFontColor,selectedShadowColor)
	changeColor(selectorTwo,selectedFontColor,selectedShadowColor)
	changeColor(selectorThree,selectedFontColor,selectedShadowColor)
	setCurrentSelection(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("ui_down")) :
		if(currentSelection < 2) :
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
