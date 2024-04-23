extends ColorRect

var score : int = 0

func add_score():
	score = clampi(score+1,0,9999)
	for i in 4:
		var dig = score%(int(pow(10,float(i+1)))) - score%(int(pow(10,float(i))))
		dig = int(dig/pow(10,float(i)))
		set_digit(get_node("digit"+str(i)),dig)

func set_digit(node:Sprite2D,value):
	if value == 0:
		node.frame = 9
	else:
		node.frame = value-1
