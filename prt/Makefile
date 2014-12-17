
all: shell disc

shell: stl/shell.stl

disc: stl/disc.stl

stl/%.stl: *.scad
	openscad $*.scad -o stl/$*.stl
