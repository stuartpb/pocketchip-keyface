//!OpenSCAD

letter_size = 4;
digit_size = 3;
symbol_size = 2;
esc_size = 2;
fnote_size = 1;
font_scale = 1;
bubble_radius = 1.5;

$fn = 24;

module label(s,size,font="Overpass:style=ExtraBold") {
  text(s,size*font_scale,font,halign="center", valign="center");
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

module key_faces () {
  translate([-45.66,25]) label("ESC", esc_size);
  translate([-45.66,4.52]) key_row("QWERTYUIOP", letter_size);
  translate([-40.58,-3.77]) key_row("ASDFGHJKL", letter_size);
  translate([-35.51,-12.07]) key_row("ZXCVBNM", letter_size);
  translate([-45.66,-12.07]) label("↹", 3);
  translate([-15.4,23.2]) {
    translate([-.8,-.8]) key_row("13579-",digit_size);
    translate([1.4,.8]) key_row("!#%&(_",symbol_size);
  }
  translate([46.4,23]) label("⇤",4);
  translate([-10.2,14.9]) {
    translate([-.8,-.8]) key_row("24680=",digit_size);
    translate([1.4,.8]) key_row("@$^*)+",symbol_size);
  }
  translate([35.4,-12.07]) {
    translate([-.5,-1]) label(".", digit_size);
    translate([1.8,.6]) label(",", symbol_size);
  }
  translate([46.55,-12.07]) label("↵", 4);
  translate([-40.58,-20.37]) label("⇧", 4,font="Mplus 1P");
  translate([-30.43,-20.37]) difference() {
    circle(3);
    label("FN", 2.5);
  }
  translate([-20.35,-20.37]) label("ALT", 2);
  translate([20.25,-20.37]) label("CTRL", 1.5);
  translate([30.4,-20.0]) {
    translate([-.8,-.8]) label("/", digit_size);
    translate([1.4,.8]) label("?", symbol_size);
  }
  translate([40.55,-20.37]) label("⇧", 4,font="Mplus 1P");
  translate([0,-31.9]) {
    intersection() {
      circle(4.4);
      union() {
        translate([-4.41,0]) square(4.4);
        translate([0,-4.41]) square(4.4);
      }
    }
  }
}

module faceplate_hints () {
  translate([5.09,4.52]) bubbled_row("{}[]|", symbol_size*.8);
  translate([10.09,-3.77]) bubbled_row("<>'\"", symbol_size*.8);
  translate([5.09,-12.07]) bubbled_row("`~:;", symbol_size*.8);
  translate([30.4,-20.37]) bubbled() label("\\",symbol_size*.8);
  translate([-15.4,23.2]) fn_hint_row(1);
  translate([-10.2,14.9]) fn_hint_row(0);
}

module key_base() {
  translate([0,0,-29]) import("PocketCHIP-Keyboard-Faceplate/VJAP_PocketCHIP_Keys.stl");
}

module faceplate_base() {
  translate([0,-32.5,-70]) import("PocketCHIP-Keyboard-Faceplate/VJAP_PocketCHIP_Faceplate.stl");
}
difference() {
color("yellow") key_base();
rotate([180,0,0]) {
  color("black") linear_extrude(1) key_faces();
  //color("black") linear_extrude(1) faceplate_hints();
}
}