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

module key_row(keys,size) {
  for (i=[0:len(keys)-1])
  translate([i*10.15,0]) label(keys[i],size);
}

module double_row(digits, symbols) {
  translate([-1.25,-.5]) key_row(digits,digit_size);
  translate([1.2,.5]) offset(delta=0.02) key_row(symbols,symbol_size,$fn=48);
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
  difference() {
    union() {
      hull() {
        translate([-18,26]) circle(4.4);
        translate([46,26]) circle(4.4);
        translate([40,14.9]) circle(5);
        //translate([5,4.52]) circle(5);
        //translate([10,-3.77]) circle(5);
        translate([-10.2,14.9]) circle(5);
      }
      hull() {
        translate([35,25]) circle(6);
        translate([48,29]) circle(4.4);
        translate([45,5.5]) circle(5.5);
        translate([30.4,-20.37]) circle(4.4);
        translate([25,-12.07]) circle(3.5);
      }
      hull() {
        translate([20,10]) circle(5);
        translate([30,-12.07]) circle(4.4);
        translate([5,-12.07]) circle(5);
        translate([30.4,10]) circle(5);
      }
      polygon([[16,12],[4.4,-4.2],[1,1.5],[0,4.5],[-4.5,9.5],[-10,10]]);
      translate([5,4.52]) circle(5);
      translate([5,-11.5]) circle(5);
    }
  translate([0,-3.77]) circle(4.4);
  translate([-5,4.52]) circle(5);
  //translate([-5,4.52]) circle(5);
  translate([-19,27]) label("F",4);
  translate([30,14.9]) difference() {
    translate([-3,1]) circle(2.4);
    translate([-4,1]) label("1",2.5);
  }
  translate([36,23.2]) difference() {
    hull () {
      circle(2.4);
      translate([3.5,4]) circle(2.4);
    }
    translate([3.5,4]) label("11",2.5);
  }
  translate([42,14.9]) difference() {
    hull () {
      circle(2.4);
      translate([4,0.8]) circle(2.4);
    }
    translate([4.1,0.8]) label("12",2.5);
  }
    translate([5.09,11]) key_row("{}[]", symbol_size);
    translate([46.1,11]) square([0.5,3.6], center=true);
    translate([10.09,1.5]) key_row("<>'\"", symbol_size);
    translate([5.09,-7.07]) key_row("`~", symbol_size);
    translate([25.39,-6.07]) key_row(":;", symbol_size);
    translate([31,-14.37]) label("\\",symbol_size);
    translate([47,30]) label("⌦",5,font="Overpass Mono");
    translate([20.25,-20.37]) circle(5);
  }
}

module key_base() {
  difference() {
    translate([0,0,-29]) import("PocketCHIP-Keyboard-Faceplate/VJAP_PocketCHIP_Keys.stl");
    translate([dpad_center[0],-dpad_center[1],-1])
      linear_extrude(2,scale=.5) square(10,center=true);
  }
}

module faceplate_base() {
  translate([0,-32.5,-70]) import("PocketCHIP-Keyboard-Faceplate/VJAP_PocketCHIP_Faceplate.stl");
}
intersection() {
  //color("yellow") key_base();
  color("yellow") faceplate_base();
  rotate([180,0,0]) {
    //color("black") linear_extrude(1) key_faces();
    color("black") linear_extrude(1) faceplate_hints();
  }
}