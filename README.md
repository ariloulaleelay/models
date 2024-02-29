Some of my models made public.

## Prerequisite

```
$ pip install yaost
```

## Building scad

```
$ <model_script.py> build-scad
$ openscad scad/<project_name>/<model_name>.scad
```

## Building stl

```
$ <model_script.py> build
# model will be at build/<project_name>/<model_name>.stl
```


## Watch mode

```
$ <model_script.py> watch # will watch source changes and rebuild .scad
$ openscad scad/<project_name>/<model_name>.scad
```
