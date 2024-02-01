#define scr_animation_system
//scr_animation_system
// This is just a generic script for the animation system.
// Ideally, you'd have one (or multiple if you're crazy like me) which handles pretty much everything.
if(animation_tran != -1){
    if(img_loop != 0){
        if((img_id/(image_number)) > img_loop){
            img_loop = -1;
        }
    }
    
    if(img_loop == -1) {
        if(img_id >= image_number){
            scr_animation_change(animation_tran);
        }
    }
}

if(img_loop == 0) {
    if(img_id >= image_number - 1) {
        img_spd = 0;
    }
}

if(effect_ind != -1 && effect_max_tim == -1 && effect_img_id >= sprite_get_number(effect_ind) - 1) && img_loop <= 0{
    effect_ind = -1;
}

// fix a bug where negatives make it go into something funky
if (sign(img_spd) == -1 && img_id < 0){
    img_id = image_number-1;
}

// fix a bug where negatives make it go into something funky
if (sign(effect_img_spd) == -1 && effect_img_id < 0){
    effect_img_id = sprite_get_number(effect_ind) -1;
}

// create any effects here
if(img_id >= sound_frame){
    if(sound_id != -1){
        audio_play_sound(sound_id,0,false);
        sound_id = -1;
    }
}

if(img_id >= damage_frame){
    //also do the effects now, this is hard-coded to an explosion for now
    if(effect_obj != -1) {
        switch(animation_id){
            case(ANIMATION_EFFECT):{
                // create an explosion effect
                with (instance_create(x,y,obj_effect)){
                    sprite_index = spr_explosion;
                    image_speed = 0.25;
                }
                break;
            }
            default:
                break;
        }
        effect_obj = -1;
    }
}

if(hold_tim == -1 || hold_frame != floor(img_id)){
    img_id += img_spd;
} else if(hold_frame == floor(img_id)){
    anim_tim += 1;
    if(anim_tim >= hold_tim){
        hold_tim = -1;
        anim_tim = 0;
    }
}

if(effect_ind != -1){
    if (effect_img_spd != 0){
        effect_img_id += effect_img_spd
    }
    
    if (effect_max_tim != -1) {
        effect_tim += 1
        if (effect_tim >= effect_max_tim){
            effect_id = -1;
            effect_max_tim = -1;
        }
    }
    
    effect_img_x = approach(effect_img_x,1,0.1);
    effect_img_y = approach(effect_img_y,1,0.1); 
}

#define scr_animation_change
/// scr_animation_change
// Not the prettiest but this is what drives most of everything.
animation_tran = -1;
damage_frame = 0;
cancel_frame = -1;
img_loop = -1;
img_x_dif = 0
img_y_dif = 0
animation_id = argument0;
img_id = 0;
effect_ind = -1;
effect_img_id = 0;
effect_img_spd = 0;
effect_x = x
effect_y = y;
move_anim = true;
hold_frame = 0;
hold_tim = -1;

switch(i_id){
    case(0): scr_animation_change_template(argument0); break;
    default: 
        show_debug_message("Unknown ID: " + i_id);
        break;
}

if(cancel_hold) {
    hold_tim = -1;
}

#define scr_animation_change_template
//scr_animation_change_template(animation_index)
// This is the template for the change script.
// Modify this to suit your needs.
switch(argument0){
    case(ANIMATION_BASIC):{
        sprite_index = spr_test;
        img_spd = 0.1;
        break;
    }

    case(ANIMATION_BASIC_DIF):{
        sprite_index = spr_test;
        img_spd = 0.5;
        img_x_dif = -10;
        break;
    }
    
    case(ANIMATION_SQUISH):{
        sprite_index = spr_test2;
        img_spd = 0.35;
        img_x = 1.5;
        img_y = 0.5;
        animation_tran = ANIMATION_BASIC;
        break;
    }
    
    case(ANIMATION_HOLD):{
        sprite_index = spr_test2;
        img_spd = 0.5;
        hold_frame = 2;
        hold_tim = 15;
        break;
    }
    
    case(ANIMATION_SOUND):{
        sprite_index = spr_test2;
        img_spd = 0.35;
        sound_frame = 1;
        sound_id = snd_test;
        animation_tran = ANIMATION_BASIC;
        break;
    }

    case(ANIMATION_EFFECT):{
        sprite_index = spr_test2;
        img_spd = 0.25;
        effect_obj = obj_effect;
        damage_frame = 2;
        animation_tran = ANIMATION_BASIC;
        break;
    }
    
    case(ANIMATION_REPEAT):{
        sprite_index = spr_test2;
        img_spd = 0.25;
        img_loop = 2;
        animation_tran = ANIMATION_BASIC;
        break;
    }
}

#define scr_animation_setup_template
/// scr_animation_setup_template
// Sets up the animation constants.
ANIMATION_BASIC = 1
ANIMATION_BASIC_DIF = 2;
ANIMATION_SQUISH = 3
ANIMATION_HOLD = 4
ANIMATION_SOUND = 5;
ANIMATION_EFFECT = 6;
ANIMATION_REPEAT = 7;
