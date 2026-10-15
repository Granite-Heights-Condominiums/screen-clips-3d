# OpenSCAD Window Screen Clip

![Window Screen Retainer Clip](clip.png)

A fully parametric, 3D-printable window screen retainer clip built in OpenSCAD. 

This model is designed to hold window screens securely in place. It features an L-bracket base with rounded corners, a structural support ridge to prevent the main arm from bending under tension, and a slotted, domed locking pin for a secure compression fit into the screen frame. 

**By default, the script automatically generates both a Left and Right clip, nested back-to-back for easy dual-printing on a single build plate.**

## Features
* **100% Parametric:** Every dimension (arm lengths, pin height, slit width) is driven by easily adjustable variables.
* **Auto-Nested Layout:** Automatically renders a mirrored pair (Left and Right side clips) rotated and spaced tightly together for efficient 3D printing.
* **Modular Codebase:** The OpenSCAD script is broken down into clean modules (`base_plate`, `lower_stem`, `support_ridge`, and `slotted_pin`), making it easy to fork and modify.
* **Compression Fit Pin:** The stepped locking pin features a hemispherical dome for easy insertion and a central slit to allow it to compress and snap tightly into place.
* **Structural Gusset:** A flat V-shaped ridge structurally ties the long arm to the main corner cylinder, preventing the bracket from snapping or bending.

## Customization

You can easily adjust the clip to fit your specific window frame by modifying the variables at the top of the `.scad` file. 

### Key Variables
| Variable | Description |
| :--- | :--- |
| `arm_long_len` | Total length of the main securing arm (Default: 22mm) |
| `arm_short_len` | Total length of the side stabilizing arm (Default: 15mm) |
| `arm_width` | Width of both bracket arms (Default: 6mm) |
| `base_thickness` | Thickness of the L-bracket base plate (Default: 1mm) |
| `stem_base_height`| Height of the solid corner cylinder (Default: 5mm) |
| `pin_narrow_diam` | Diameter of the lower, narrower pin section (Default: 4mm) |
| `pin_total_height`| Total height of the domed upper pin (Default: 5mm) |
| `pin_slit_width` | Width of the compression slot (Default: 1.5mm) |

## Usage

1. Download and install [OpenSCAD](https://openscad.org/).
2. Open `window_screen_clip.scad` in the application.
3. Modify the configuration variables at the top of the file to match your hardware dimensions.
4. Press `F5` to preview the model. (You will see both the left and right clips arranged together).
5. Press `F6` to render the final geometry.
6. Press `F7` to export the model as an STL or 3MF file for 3D printing.

## 3D Printing Recommendations

* **Material:** PETG or ABS/ASA is recommended for UV resistance and slight flexibility (crucial for the snap-fit pin). PLA can be used but may become brittle over time if exposed to direct sunlight.
* **Orientation:** Print flat on the build plate (the bottom of the L-bracket should touch the bed). 
* **Supports:** No supports are required. The domed top of the pin prints cleanly on most modern FDM printers.
* **Infill:** 15-20% is usually sufficient, though printing with 3-4 perimeters will naturally make the thin arms and pin solid plastic.

## License
This project is licensed under the MIT License - see the LICENSE file for details.
