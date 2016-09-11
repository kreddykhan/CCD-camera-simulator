# CameraSimulator

This Matlab code simulates the process of taking a photo with a CCD camera.
The camera takes a snapshot of a section of a black and white image. It incorporates a user inputted pixel binning value and integration in the form of Riemann sums to come up with a grayscale value for each pixel on the generated photo.

Still in development stage. The code is in need of proper commenting, improvement in modularity and some bug checks.

The demo file provides an example of the code running. The demo takes about 9 seconds due to the number of sums taken. This number can also be editted in the camera_integrals file.
