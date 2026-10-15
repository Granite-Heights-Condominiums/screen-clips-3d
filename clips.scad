/*
  ===================================================================
  WINDOW SCREEN HOLDER CLIP
  ===================================================================
  A securing clip for window screens featuring an L-shaped base bracket, 
  a structural support ridge, and a stepped, domed locking pin with a 
  compression slit.
  ===================================================================
*/

// --- Configuration Variables ---

/* [Base Plate Dimensions] */
arm_long_len = 22;      // Total length of the main securing arm (X-axis)
arm_short_len = 15;     // Total length of the side stabilizing arm (Y-axis)
arm_width = 6;          // Width of both arms
base_thickness = 1;     // Z-height of the L-bracket base plate

/* [Structural Support] */
ridge_height = 1;       // Height of the flat support ridge on the long arm

/* [Lower Stem Base] */
stem_base_height = 5;   // Z-height of the main corner support cylinder

/* [Upper Locking Pin (Domed & Slotted)] */
pin_narrow_diam = 4;        // Diameter of the lower, narrower pin section
pin_narrow_height = 1.5;    // Height of the narrow section before expanding
pin_fat_expansion = 0.75;   // Additional diameter added to the upper fat section
pin_total_height = 5;       // Total Z-height of the upper pin (including dome)
pin_slit_width = 1.5;       // Width of the compression slot

/* [Rendering] */
$fn = 64; 

// --- Functions ---

// Calculates the exact radius needed for the corner cylinder to sit flush 
// against the outer origin walls while simultaneously touching the inner corner.
function get_corner_radius(w) = 2 * w - w * sqrt(2);


// --- Modules ---

// 1. The flat L-shaped bracket with rounded ends and a chamfered outer corner
module base_plate(corner_r) {
    linear_extrude(height = base_thickness) {
        union() {
            difference() {
                union() {
                    // Horizontal Long Arm
                    square([arm_long_len - arm_width/2, arm_width]); 
                    translate([arm_long_len - arm_width/2, arm_width/2])
                        circle(d = arm_width);

                    // Vertical Short Arm
                    square([arm_width, arm_short_len - arm_width/2]); 
                    translate([arm_width/2, arm_short_len - arm_width/2])
                        circle(d = arm_width);
                }
                
                // Remove the sharp outer corner to make room for the stem base
                translate([-1, -1]) 
                    square([corner_r + 1, corner_r + 1]);
            }
            
            // Insert the perfectly calculated rounded outer corner
            translate([corner_r, corner_r])
                circle(r = corner_r);
        }
    }
}

// 2. The main structural cylinder sitting at the corner intersection
module lower_stem(corner_r) {
    linear_extrude(height = stem_base_height) {
        translate([corner_r, corner_r])
            circle(r = corner_r);
    }
}

// 3. The flat > shaped ridge that reinforces the long arm from bending
module support_ridge(corner_r) {
    translate([0, 0, base_thickness]) {
        linear_extrude(height = ridge_height) {
            margin = 1; // 1mm margin from side walls
            tip_r = 1;  // Radius of the curved tip
            tip_x = arm_long_len - margin - tip_r; 
            
            hull() {
                // Wide base deeply embedded inside the lower stem for a solid mesh
                translate([corner_r, margin])
                    square([0.1, arm_width - 2 * margin]);
                
                // Curved tip centered 1mm from the edge of the long arm
                translate([tip_x, arm_width / 2])
                    circle(r = tip_r);
            }
        }
    }
}

// 4. The snap-fit upper pin featuring a step, a hemispherical dome, and a slit
module slotted_pin(corner_r) {
    fat_diam = pin_narrow_diam + pin_fat_expansion; 
    fat_radius = fat_diam / 2; 
    
    // Remaining straight height for the fat section after accounting for dome
    fat_cyl_h = (pin_total_height - pin_narrow_height) - fat_radius;
    
    difference() {
        // Solid stepped domed pin
        translate([corner_r, corner_r, stem_base_height]) {
            // Lower narrow section
            cylinder(h = pin_narrow_height, d = pin_narrow_diam);
            
            // Upper fat section
            translate([0, 0, pin_narrow_height]) {
                cylinder(h = fat_cyl_h, d = fat_diam);
                
                // Hemispherical domed cap
                translate([0, 0, fat_cyl_h])
                    sphere(d = fat_diam);
            }
        }
        
        // Compression slit cutter (Aligned parallel to the Long Arm)
        translate([corner_r, corner_r, stem_base_height + pin_total_height/2])
            cube([fat_diam + 2, pin_slit_width, pin_total_height + 2], center = true);
    }
}


// --- Main Assembly ---

// Wraps all components into a single coherent part
module window_screen_clip() {
    corner_r = get_corner_radius(arm_width);
    
    union() {
        base_plate(corner_r);
        lower_stem(corner_r);
        support_ridge(corner_r);
        slotted_pin(corner_r);
    }
}

// Render the final layout
    translate([0, -1, 0]) rotate(180) window_screen_clip();
    translate([0, 1, 0])
        mirror([1, 0, 0]) window_screen_clip();