#define Generic_Scripts
// just a collection of generic scripts i've made/reimplemented from other sources
// if it's not entirely mine, i've linked where i got it from in the script

#define approach
/// approach(start, end, shift)
// from zack bell's wonderful series on 2d platformers (https://zackbellgames.wordpress.com/2014/10/28/devlog-creating-a-platformer-pt-2/)
if (argument0 < argument1) return min(argument0 + argument2, argument1); 
return max(argument0 - argument2, argument1);

#define approach_lerp
/// approach_lerp(start, end, direction, rate)
// modified from approach
var tLerp;

tLerp = lerp(argument0, argument1, argument3); 

if((argument2 && tLerp >= argument1) || (!argument2 && tLerp <= argument1)) {
    return argument1;
} else {
    return tLerp;
}

#define check_array_value
/// check_array_value( array, valueToCheck )
// This checks to see if the value provided is in a provided array
var arr, val, i;
arr = argument0;
val = argument1;

for(i = 0; i < array_length_1d(arr); i++){
    if(arr[i] == val) {
        return true;
    }
}
return false;

#define array_delete
/// array_delete(arr, t_pos)
// Deletes an index in an array
var arr = argument0;
var t_pos = argument1;
var arr_len = array_length_1d(arr);
if (arr_len > 0 && t_pos >= 0 && t_pos < arr_len) {
    var new_arr = array_create(arr_len-1);
    array_copy(new_arr, 0, arr, 0, t_pos);
    array_copy(new_arr, t_pos, arr, t_pos+1, arr_len-(t_pos+1));
    return new_arr;
} else {
    return arr;
}

#define draw_repeating_sprite
/// draw_repeating_sprite(sprite_index, x1, y1, x2, y2)
// Draws a sprite repeating until a specific point
var sprite, x1, y1, x2, y2, angle;

sprite = argument0;
x1 = argument1;
x2 = argument3;
y1 = argument2;
y2 = argument4;

var w_diff = x2 - x1;
var h_diff = y1 - y2;
var angle = darctan2(h_diff,w_diff);
var length = w_diff/dcos(angle);
var iMax = abs(length)/sprite_get_width(sprite);

for(i = 0; i <= iMax; i++){
    draw_sprite_ext(sprite,image_index,x1 + ((i * sprite_get_width(sprite))*dcos(angle)),y1 + (i * sprite_get_height(sprite))*dsin(angle),1,1,-angle,image_blend,image_alpha);
}

#define draw_stretched_angle
/// draw_stretched_angle(sprite_index, image_index, x1, y1, x2, y2)
// Draws a sprite repeating until a specific point
var sprite, x1, y1, x2, y2, angle;

sprite = argument0;
sprite_id = argument1;
x1 = argument2;
x2 = argument4;
y1 = argument3;
y2 = argument5;

var w_diff = x2 - x1;
var h_diff = y1 - y2;
var angle = darctan2(h_diff,w_diff);
var length = w_diff/dcos(angle);
var relative_width = abs(length)/sprite_get_width(sprite);

draw_sprite_ext(sprite,sprite_id,x1,y1,relative_width,1,angle,image_blend,image_alpha);