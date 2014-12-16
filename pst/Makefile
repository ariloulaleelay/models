
all: shell cap disc

shell: stl/shell.stl

disc: stl/disc.stl

cap: stl/cap.stl

stl/%.stl: *.scad
	openscad $*.scad -o stl/$*.stl
