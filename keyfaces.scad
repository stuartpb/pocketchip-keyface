//!OpenSCAD

letter_size = 4;
digit_size = 3;
symbol_size = 3;
esc_size = 2;
fnote_size = 1;
font_scale = 1;
bubble_radius = 1.5;

$fn = 24;

dpad_center = [-30.4368, 19.0053];

module label(s,size,font="Overpass:style=ExtraBold") {
  text(s,size*font_scale,font,halign="center", valign="center");
}

module key_row(keys,size) {
  for (i=[0:len(keys)])
  translate([i*10.15,0]) label(keys[i],size);
}

module dir_tri() {
  polygon([
    [-1.25,5.5],
    [0,7.5],
    [1.25,5.5]
  ]);
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

module double_row(digits, symbols) {
  translate([-1.25,-.5]) key_row(digits,digit_size);
  translate([1.2,.5]) offset(delta=0.02) key_row(symbols,symbol_size,$fn=48);
}

module bubbled_row(keys,size) {
  for (i=[0:len(keys)-1])
  translate([i*10.15,0]) bubbled() label(keys[i],size);
}

module key_faces () {
  translate([-45.66,25]) offset(delta=0.025) label("⎋", 4, font="Inter");
  translate([-45.66,4.52]) key_row("QWERTYUIOP", letter_size);
  translate([-40.58,-3.77]) key_row("ASDFGHJKL", letter_size);
  translate([-35.51,-12.07]) key_row("ZXCVBNM", letter_size);
  translate([-45.66,-12.07]) label("↹", 3);
  translate([-15.4,23.2]) double_row("13579-","!#%&(_");
  translate([46.4,23]) label("⇤",4);
  translate([-10.2,14.9]){
    double_row("24680="," $^*)+");
    translate([1.2,.5]) offset(delta=0.04) label("@",symbol_size,$fn=96);
  }
  translate([35.4,-12.07]) double_row(".",",");
  translate([46.55,-12.07]) label("↵", 4);
  translate([-40.58,-20.37]) offset(delta=0.1) label("⇧", 4,font="Mplus 1P");
  translate([-30.43,-20.37]) difference() {
    circle(3);
    label("Fn", 2.5);
  }
  translate([-20.35,-20.37]) offset(delta=0.05) label("Alt", 2.5);
  translate([20.25,-20.37]) offset(delta=0.05) label("Ctrl", 2.5);
  translate([30.4,-20.0]) double_row("/","?");
  translate([40.55,-20.37]) offset(delta=0.1) label("⇧", 4,font="Mplus 1P");
  translate([0,-31.9]) {
    intersection() {
      circle(4.4);
      union() {
        translate([-4.401,0]) square(4.4);
        translate([0,-4.401]) square(4.4);
      }
    }
  }
  translate(dpad_center) {
    dir_tri();
    rotate(90) dir_tri();
    rotate(180) dir_tri();
    rotate(270) dir_tri();
  }
}

module faceplate_hints () {
  translate([5.09,4.52]) bubbled_row("{}[]|", symbol_size*.8);
  translate([10.09,-3.77]) bubbled_row("<>'\"", symbol_size*.8);
  translate([5.09,-12.07]) bubbled_row("`~:;", symbol_size*.8);
  translate([30.4,-20.37]) bubbled() label("\\",symbol_size*.8);
}

module key_base() {
  difference() {
    translate([0,0,-29]) import("PocketCHIP-Keyboard-Faceplate/VJAP_PocketCHIP_Keys.stl");
    translate([dpad_center[0],-dpad_center[1],-1])
      linear_extrude(2,scale=.5) square(10,center=true);
  }
}

module faceplate_base() {
  translate([0,-32.5,-69]) import("PocketCHIP-Keyboard-Faceplate/VJAP_PocketCHIP_Faceplate.stl");
}
difference() {
  color("yellow") key_base();
  //color("yellow") faceplate_base();
  rotate([180,0,0]) {
    color("black") linear_extrude(1) key_faces();
    //color("black") linear_extrude(1) faceplate_hints();
  }
}