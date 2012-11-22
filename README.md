# CDMedallionView
A medallion view for OS X, like the login image view introduced in OS X Lion.

Supports retina displays.

<img alt="The medallion view in three different sizes" src="http://cloud.github.com/downloads/rastersize/CDMedallionView/CDMedallionView@2x.png" width="408px" height="336px">

## Getting started 
- Get the source;
	- as a git submodule: `git submodule add https://github.com/rastersize/CDMedallionView.git Vendor/CDMedallionView && git submodule update --init --recursive`
	- or by [download the source as a zip](https://github.com/rastersize/CDMedallionView/archive/master.zip) and extracting it in your vendor directory.
- Add the the source files (`CDMedallionView.{h,m}`) to your Xcode project.
	- Make sure they are compiled using ARC.
- Use the class as if it was a normal `NSImageView` and configure the stuff you need such as border width, color and whether a shine should be added.

## Requirements
_CDMedallionView_ requires ARC.

If you do not use it and want to compile the source files yourself just add `-fobjc-arc` to the compiler flags of the `CDMedallionView.m` file. You can also just link against the framework in which case everything should work out of the box.

## Credits
_CDMedallionView_ was created by [Aron Cedercrantz](https://github.com/rastersize).


## License
_CDMedallionView_ is licensed under the MIT license. For the specifics see [the license](https://github.com/rastersize/CDMedallionView/blob/master/LICENSE) file.

