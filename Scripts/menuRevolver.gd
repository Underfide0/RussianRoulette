extends Control

@export var LineEdit1 : LineEdit
@export var LineEdit2 : LineEdit
@export var LineEdit3 : LineEdit
@export var LineEdit4 : LineEdit
@export var LineEdit5 : LineEdit
@export var LineEdit6 : LineEdit

func applyNames():
	$"../Personas/Ruben".text = $LineEdit.text
	$"../Personas/Andreu".text = $LineEdit2.text
	$"../Personas/Nadia".text = $LineEdit3.text
	$"../Personas/Ricardo".text = $LineEdit4.text
	$"../Personas/Alberto".text = $LineEdit5.text
	$"../Personas/Ulises".text = $LineEdit6.text
	$"..".stats_update()
	$"../AnimPlayer".play("shoot")
	await get_tree().create_timer(1).timeout
	$".".hide()
	
	
