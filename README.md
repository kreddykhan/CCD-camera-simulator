# CameraSimulator

**Warning**: CameraSimulator is still in development. The code needs to be documented and tested for rotations.

## Introduction

This Matlab code simulates the process of taking a photo with a CCD camera.

The intended use is to simulate the process of taking multiple photos of the same background with known translations or rotations between photos.

It incorporates a user inputted pixel binning value and integration in the form of Riemann sums to come up with a grayscale value for each pixel on the generated photo.

The demo file provides an example of the code running. The demo takes about 9 seconds due to the number of sums taken. This number can also be editted in the camera_integrals file.

## API
The code uses a baseline image and takes the following parameters:

- `pixel_number`: The numbers of pixels the camera photo will have.
- `pixel_unit`: The units (in microns) of the pixel length.
- `x0`: The initial `x` coordinte of the photo’s center.
- `x_translation`: Translation along the x-axis from the intial `x` location.
- `y0`: The initial `y` coordinte of the photo’s center.
- `y_translation`: Translation along the y-axis from the intial `y` location
- `magnification`: Magnification of the camera, *not* the photo itself.
- `rotation`: Rotation relative to the center axes (`x0`, `y0`).
- `RGB`: The background of the "photo".

The code initially uses the `camera_points.m` file to take the inputted parameters and determines the four corners of the photo relative to the background. This is determined using the `pixel_number` and `pixel_unit` and the units of the pixels of `RGB`. `RGB` is assumed to be 1 micron per pixel in the demo. **This needs to be updated to allow user inputs**

Having determined the corners, the code then uses the `camera_integrals_large.m` file to find the slope of the lines of the tapezoid formed by the four corners. The slopes of these lines are used to partition the trapezoid into smaller trapezoids based on the inputted `pixel_number` and `magnification`. This technique is called pixel bining. The technique essentially smears the original pixels into one pixel for the region defined by the bin and this is what the photo prints.

Each of the smaller trapezoids (the bins) are then run through the `camera_integrals.m` code. This code does essentially the same thing as the `camera_integrals_large.m` in terms of finding the slopes of the lines and partitioning into smaller units. These units are set by the user in the `camera_integrals.m` file. The difference is instead of just partitioning into smaller trapezoids, it references the value from `RGB` associated with that partitioned location. It does this for all the points and uses the values to determine the average value for the pixel. This value is returned. After the process runs on all the pixel bins, a photographed CCD grayscale image remains.
