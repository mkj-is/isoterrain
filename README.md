# Isoterrain 1.0

Isoterrain project was made as semestral work in PV097 course at Faculty of Informatics, Masaryk University, Brno. It was inspired by Timothy J. Reynolds low-poly isometric islands. The Isoterrain application generates random, infinite and living terrains.

## Requirements

Project was createn in Processing, version 2.1. For running the project Java 7 is required.

## Controls

Application can be controlled using keyboard.

- `Arrow`: Movement
- `I`: Infographics about maps
- `H`: Show/hide help
- `S`: Save to PNG
- `E`: Export fo configuration to TXT
- `0-9`: Select layer
- `M/L`: Bigger/smaller miagnitude of selected layer
- `U/D`: Move selected layer up and down
- `RGBA`: Change color of selected layer
- `T`: Turn on/off and selects top cutoff of selected layer
- `Z`: Turn on/off and selects bottom cutoff of selected layer
- `O/P`: Move selected cutoff up/down
- `X`: Stop time

## Configuration

Configuration is saved after pressing `E` key. If you want to load your own configuration, put the file with configuration into the app folder and rename it to `config.txt`. If it does not work, add the file to home directory of currently logged in user. If is this configuration file valid then the layers from this file will be loaded instead of the default layers.

### Example configuration

This is configuration without any changes to layer parameters.

	Time=56.632595
	Position=67.28607,84.86561
	---
	Water
	Offset=215.87689,198.29736
	Magnitude=20.0
	Height=-25.0
	Color=42,186,178,180
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0
	---
	Hills
	Offset=67.28607,84.86561
	Magnitude=150.0
	Height=-100.0
	Color=236,246,122,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=100.0,0.0
	---
	Mountains
	Offset=67.336075,84.91561
	Magnitude=300.0
	Height=-150.0
	Color=173,57,44,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=160.0,0.0
	---
	Snow
	Offset=67.38607,84.96561
	Magnitude=500.0
	Height=-200.0
	Color=220,220,220,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=215.0,0.0

## Creating/Editing the configuration file

First two lines contain global variables. On the first line there is internal time of the app. On the second line is actual position on the map (offset in Perlin noise). The lines cannot be swapped. Values are decimal number using period.

	Time=56.632595
	Position=67.28607,84.86561

### Layers of terrain in the configuration file

Global variables are followed by layers. Number of layers varies between 0 and 10. Lines in layer configuration cannot be swapped too. Format of one layer looks like this example (three hyphens divide the layers):

	---
	Hills
	Offset=67.28607,84.86561
	Magnitude=150.0
	Height=-100.0
	Color=236,246,122,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=100.0,0.0

Here is the detailed definition of all the values that define the layer:

	---
	Hills

Layer description.

	Offset=67.28607,84.86561

Position on the map.

	Magnitude=150.0

Multiplier of the Perlin noise value.

	Height=-100.0

Base height of the layer.

	Color=236,246,122,255

Color in RGBA (0-255).

	Scale=0.3

Distance between two samples from Perlin noise.

	Cutoffs=true,false

Values enabling top and bottom cut off.

	Cut values=100.0,0.0

Values of top and bottom cutoff.

Layer 0 is always moving.

## Examples

### Application with enabled interface

![Application with enabled interface](https://dl.dropboxusercontent.com/u/216967/isoterrain/example_ui.png)

### Default configuration

![Classic configuration](https://dl.dropboxusercontent.com/u/216967/isoterrain/classic.png)

	Time=58.34304
	Position=197.38326,-2.632732
	---
	Water
	Offset=291.7152,291.7152
	Magnitude=20.0
	Height=-25.0
	Color=42,186,178,180
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0
	---
	Hills
	Offset=197.38326,-2.632732
	Magnitude=150.0
	Height=-100.0
	Color=236,246,122,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=100.0,0.0
	---
	Mountains
	Offset=197.43326,-2.5827322
	Magnitude=300.0
	Height=-150.0
	Color=173,57,44,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=160.0,0.0
	---
	Snow
	Offset=197.48325,-2.532732
	Magnitude=500.0
	Height=-200.0
	Color=220,220,220,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=215.0,0.0

### Volcanoes

![Volcanoes](https://dl.dropboxusercontent.com/u/216967/isoterrain/volcanoes.png)

	Time=215.65913
	Position=103.75135,160.70026
	---
	Lava
	Offset=1078.2957,1078.2957
	Magnitude=20.0
	Height=45.0
	Color=95,0,5,250
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0
	---
	Floor
	Offset=103.75135,160.70026
	Magnitude=150.0
	Height=65.0
	Color=0,10,5,255
	Scale=0.3
	Cutoffs=false,true
	Cut values=100.0,0.0
	---
	Volcanoes
	Offset=103.801346,160.75026
	Magnitude=445.0
	Height=-195.0
	Color=0,0,5,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=270.0,0.0
	---
	Magma
	Offset=103.85135,160.80026
	Magnitude=500.0
	Height=-200.0
	Color=145,5,0,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=265.0,0.0

### Shallow

![Shallow](https://dl.dropboxusercontent.com/u/216967/isoterrain/shallow.png)

	Time=191.4628
	Position=192.22195,78.166695
	---
	Water
	Offset=874.90857,893.0499
	Magnitude=30.0
	Height=-25.0
	Color=42,186,178,250
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0
	---
	Sandstones
	Offset=192.22195,78.166695
	Magnitude=150.0
	Height=0.0
	Color=236,246,122,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=75.0,0.0
	---
	Rocks
	Offset=192.27196,78.21669
	Magnitude=300.0
	Height=-40.0
	Color=173,57,44,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=120.0,70.0
	---
	Sand
	Offset=192.32196,78.26669
	Magnitude=20.0
	Height=55.0
	Color=240,240,150,255
	Scale=0.3
	Cutoffs=true,false
	Cut values=215.0,0.0

### Desert

![Desert](https://dl.dropboxusercontent.com/u/216967/isoterrain/desert.png)

	Time=285.22583
	Position=192.22195,78.166695
	---
	Underground water
	Offset=1350.7043,1413.4845
	Magnitude=30.0
	Height=125.0
	Color=25,105,205,255
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0
	---
	Sand
	Offset=874.90857,893.0499
	Magnitude=30.0
	Height=-150.0
	Color=240,220,50,255
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0
	---
	Sandstone
	Offset=874.90857,893.0499
	Magnitude=50.0
	Height=-100.0
	Color=210,170,20,255
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0
	---
	Mud
	Offset=874.90857,893.0499
	Magnitude=65.0
	Height=-30.0
	Color=70,65,0,255
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0
	---
	Dark mud
	Offset=874.90857,893.0499
	Magnitude=75.0
	Height=45.0
	Color=65,75,10,255
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0
	---
	Stone
	Offset=874.90857,893.0499
	Magnitude=30.0
	Height=155.0
	Color=30,30,35,255
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0
	---
	Rock
	Offset=874.90857,893.0499
	Magnitude=30.0
	Height=295.0
	Color=10,10,10,255
	Scale=0.5
	Cutoffs=false,false
	Cut values=0.0,0.0

## Links

- My portfolio: http://mkj.is
- Course information: https://is.muni.cz/predmet/fi/podzim2013/PV097?lang=en
- Inspiration by Timothy J. Reynolds: http://dribbble.com/shots/767412-Island-Map

