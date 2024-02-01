#define Generic_Scripts
// just a collection of generic scripts i've made/implemented 
// if i've taken inspiration from another source, it's credit in the relevant script

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

