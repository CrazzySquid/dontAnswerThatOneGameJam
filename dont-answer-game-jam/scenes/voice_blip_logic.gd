extends Control
# Typewriter dialogue: every second letter plays the speaker's blip. Click or press Space/Enter to skip or advance.
var lines=[["Pip","sans_voice.mp3","Hello im a Monster and im hunting you, the exit is in the spooky direction."],
["Old Moss","monster_voice3.mp3","Im the Ranger and the exit is actually in the exit looking direction!"],
["UNIT-7","monster_voice4.mp3","SWAP THE BLIP FILE TO CHANGE THE VOICE."]]

var li=0; var ci=0; var acc=0.0; var p:AudioStreamPlayer; var name_lbl:Label; var text_lbl:Label

func _ready():
	var bg=ColorRect.new(); bg.color=Color("27304a"); bg.set_anchors_preset(PRESET_FULL_RECT); add_child(bg)
	p=AudioStreamPlayer.new(); add_child(p)
	var box=Panel.new(); box.position=Vector2(140,380); box.size=Vector2(1000,260); add_child(box)
	name_lbl=Label.new(); name_lbl.position=Vector2(170,400); name_lbl.add_theme_font_size_override("font_size",32); add_child(name_lbl)
	text_lbl=Label.new(); text_lbl.position=Vector2(170,460); text_lbl.size=Vector2(940,160); text_lbl.autowrap_mode=TextServer.AUTOWRAP_WORD; text_lbl.add_theme_font_size_override("font_size",34); add_child(text_lbl)
	_show()

func _show():
	name_lbl.text=lines[li][0]+"  ("+lines[li][1]+")"; p.stream=load("res://sound/sound_effects/voice_blips/"+lines[li][1]); text_lbl.text=lines[li][2]; text_lbl.visible_characters=0; ci=0

func _process(dt):
	acc+=dt
	var s:String=lines[li][2]
	if ci<s.length() and acc>=0.05:
		acc=0.0; ci+=1; text_lbl.visible_characters=ci
		if s[ci-1]!=" " and ci%2==1: p.play()
		
func _unhandled_input(e):
	if (e is InputEventMouseButton and e.pressed) or e.is_action_pressed("ui_accept"):
		if ci<lines[li][2].length(): ci=lines[li][2].length(); text_lbl.visible_characters=-1
		else: li=(li+1)%lines.size(); _show()
