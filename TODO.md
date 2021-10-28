# Ray tracing

### article
https://medium.com/swlh/ray-tracing-from-scratch-in-python-41670e6a96f9
https://www.scratchapixel.com/code.php?id=8&origin=/lessons/3d-basic-rendering/ray-tracing-overview


```
config {
    max_depth = ...
    camera = ...
    background = ...
    objects = ...
}

let intersect_nearest objects ray = ...


let rec send_ray ray objects max_depth = 
    let object = intersect_nearest objects ray in
    match object with
    | None => black
    | Some object =>
        if is_shadow then
            black
        else
            (* ilumination ambiant *)
            ...
    
            (* ilumination diffuse *)
            ...

            (* ilumination specular *)
            ...

            (* ilumination reflexion *)
            ...

let get_color camera pi


for (each pixel)
    ray = ...
    pixel = get_color ray objects
}
```
- [ ] output
    - [X] ppm
    - [X] ascii output
- [ ] objects
    - [ ] interface
    - [ ] sphere
    - [ ] mesh
- [ ] Simple ray tracing (one bounce)
    - [ ] scene
        - [ ] file ?
        - [ ] camera
        - [ ] screen
        - [ ] objects
            - [ ] position
            - [ ] material
        - [ ] light
            - [ ] ambiant
            - [ ] directional
            - [ ] point
    - [ ] illumination ambiant
    - [ ] shadow

- [ ] Advanced
    - [ ] scene
        - [ ] camera
            - [ ] fov
        - [ ] objects
            - [ ] rotation
            - [ ] scale
    - [ ] illumination specular
    - [ ] illumination difuse
    - [ ] illumination reflexion
        - [ ] transparency
    - [ ] smooth mesh
- [ ] Optimisation
    - [ ] octree
    - [ ] threads
