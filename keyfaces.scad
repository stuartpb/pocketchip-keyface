//!OpenSCAD

letter_size = 4;
digit_size = 3;
symbol_size = 2;
esc_size = 2;
fnote_size = 1;
font_scale = 1;
bubble_radius = 1.5;

$fn = 24;

module label(s,size) {
  text(s,size*font_scale,font="Overpass",halign="center", valign="center");
}

module key_row(keys,size) {
  for (i=[0:len(keys)])
  translate([i*10.15,0]) label(keys[i],size);
}

module bubbled () {
  translate([-5,2.6]) difference() {
    union() {
      circle(bubble_radius);
      rotate(-30) translate([0,-bubble_radius]) square(2*bubble_radius);
    }
    children();
  }
}

module key_row(keys,size) {
  for (i=[0:len(keys)-1])
  translate([i*10.15,0]) label(keys[i],size);
}

module bubbled_row(keys,size) {
  for (i=[0:len(keys)-1])
  translate([i*10.15,0]) bubbled() label(keys[i],size);
}

module fn_hint_row(odd) {
  for (i=[0:5])
  translate([i*10.15,0]) bubbled() rotate(-30) label(str("F",(i+1)*2-odd),1.1);
}

//circle(3,$fn=90);

module key_faces () {
  translate([-45.66,25]) label("ESC", esc_size);
  translate([-45.66,4.5]) key_row("QWERTYUIOP", letter_size);
  translate([-40.66,-3.8]) key_row("ASDFGHJKL", letter_size);
  translate([-35.51,-12.2]) key_row("ZXCVBNM", letter_size);
  translate([-45.66,-12.2]) label("↹", 3);
  translate([-15.4,23.2]) {
    translate([-.5,-1]) key_row("13579-",digit_size);
    //translate([-1.8,.6]) key_row("FFFFF",fnote_size);
    //translate([49.25,1.2]) rotate(45) label("F11",fnote_size);
    translate([1.8,.6]) key_row("!#%&(_",symbol_size);
  }
  translate([46.4,23]) label("⇤",4);
  translate([-10.2,14.9]) {
    translate([-.5,-1]) key_row("24680=",digit_size);
    //translate([-1.8,.6]) key_row("FFFF",fnote_size);
    //translate([38.8,.6]) rotate(-45) label("F1",fnote_size);
    //translate([49.25,1.2]) rotate(45) label("F12",fnote_size);
    translate([1.8,.6]) key_row("@$^*)+",symbol_size);
  }
  translate([35.4,-12.2]) {
    translate([-.5,-1]) label(".", digit_size);
    translate([1.8,.6]) label(",", symbol_size);
  }
  translate([46.55,-12.2]) label("↵", 4);
  translate([-40.66,-20.35]) label("SHIFT", 1.5);
  translate([-30.43,-20.37]) difference() {
    circle(3);
    label("FN", 2.5);
  }
  translate([-20.35,-20.35]) label("ALT", 2);
  translate([20.25,-20.35]) label("CTRL", 1.5);
  translate([30.4,-20.0]) {
    translate([-.5,-1]) label("/", digit_size);
    translate([1.8,.6]) label("?", symbol_size);
  }
  translate([40.55,-20.35]) label("SHIFT", 1.5);
  translate([0,-32]) label("HOME", 1.5);
}

module faceplate_hints () {
  translate([5.09,4.5]) bubbled_row("{}[]|", symbol_size*.8);
  translate([10.09,-3.8]) bubbled_row("<>'\"", symbol_size*.8);
  translate([5.09,-12.2]) bubbled_row("`~:;", symbol_size*.8);
  translate([30.4,-20.35]) bubbled() label("\\",symbol_size*.8);
  translate([-15.4,23.2]) fn_hint_row(1);
  translate([-10.2,14.9]) fn_hint_row(0);
}

module key_base() {
  translate([0,0,-28]) import("PocketCHIP-Keyboard-Faceplate/VJAP_PocketCHIP_Keys.stl");
}

module faceplate_base() {
  translate([0,-32.5,-69]) import("PocketCHIP-Keyboard-Faceplate/VJAP_PocketCHIP_Faceplate.stl");
}

key_base();
rotate([180,0,0]) {
  #key_faces();
  //#faceplate_hints();
}