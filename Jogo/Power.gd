extends TextureRect

var value_recovery = 1
var value_use = 1

func update_power():
	$powerFire.value = clampi($powerFire.value + value_recovery,0,10)

func use_power():
	$powerFire.value = 0
	use_power_special()

func use_power_special():
	$powerSpecial.value = clampi($powerSpecial.value-value_use,0,10)

func is_power_max(max_power):
	return $powerFire.value == max_power
