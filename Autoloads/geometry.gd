extends Node

# Temp function, i'm sure there's a prebuild one.
func diff_angles(angle1, angle2):
	return fmod(fmod(angle1, 2 * PI) - fmod(angle2, 2 * PI) + 3 * PI, 2 * PI) - PI
	
func wrap_angle(angle):
	return fmod(angle + 3*PI, 2*PI) - 3*PI
