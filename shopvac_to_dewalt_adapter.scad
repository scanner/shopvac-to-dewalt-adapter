// An adapter to fit the hose from my Shop-Vac 9520262 5-Gallon
// 4.5-Peak HP Hang Up Wall Mounted Wet/Dry Vacuum to the dust adapter
// on my DeWalt DW705 12" mitre saw.
//
wall_thickness = 3;
dw_adapter_id = 40;
sv_adapter_id = 31.5;

dw_h = 28;
sv_h = 30;
joiner_h = 15;
$fn = 80;

version = 1.0;

module dw_fitting() {
  difference() {
    cylinder(h=dw_h, r=(dw_adapter_id / 2) + wall_thickness, center=true);
    cylinder(h=dw_h+0.1, r=(dw_adapter_id / 2), center=true);
  }
}

module sv_fitting() {
  difference() {
    cylinder(h=sv_h, r=(sv_adapter_id / 2) + wall_thickness, center=true);
    cylinder(h=sv_h+0.1, r=(sv_adapter_id / 2), center=true);
  }
}

module cylinder_joiner() {
  difference() {
    cylinder(h=joiner_h, r1=(dw_adapter_id / 2) + wall_thickness,
             r2=(sv_adapter_id / 2), center=true);
    cylinder(h=joiner_h+0.1, r=(sv_adapter_id / 2), center=true);
  }
}

module adapter() {
  translate(v=[0,0,sv_h+(dw_h/2)]) {
    mirror([0,0,1]) {
      union() {
        dw_fitting();
        translate(v=[0,0,(dw_h/2) + (sv_h/2)]) {
          sv_fitting();
        }
        translate(v=[0,0,(dw_h/2) + (joiner_h/2)]) {
          cylinder_joiner();
        }
      }
    }
  }
}

adapter();
/* dw_fitting(); */
/* sv_fitting(); */
