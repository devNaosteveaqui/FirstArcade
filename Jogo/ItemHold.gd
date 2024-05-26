extends TextureRect

func change_item(type:Shot.TYPE_SPECIAL_SHOOT_BASE):
	match type:
		Shot.TYPE_SPECIAL_SHOOT_BASE.DONUT:
			if not $item.is_visible_in_tree():
				$item.show()
			$item.frame = 0
		Shot.TYPE_SPECIAL_SHOOT_BASE.SQUARE:
			if not $item.is_visible_in_tree():
				$item.show()
			$item.frame = 1
		Shot.TYPE_SPECIAL_SHOOT_BASE.MISSEL:
			if not $item.is_visible_in_tree():
				$item.show()
			$item.frame = 2
		_:
			if $item.is_visible_in_tree():
				$item.hide()
			$item.frame = 0
