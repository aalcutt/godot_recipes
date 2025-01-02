
A quick reference of things I know change between Godot v3 and v4

### Official migration docs
https://docs.godotengine.org/en/stable/tutorials/migrating/upgrading_to_godot_4.html

## export, onready
```
# v3
export var velocity = Vector2.ZERO
onready var camera = $Camera2D

# v4
@export var velocity = Vector2.ZERO
@onready var camera = $Camera2D
```

## yield replaced with await
```
# v3
yield(get_tree().create_timer(1.0),"timeout")

# v4
await get_tree().create_timer(1.0).timeout
```

## KinematicBody2D replaced with CharacterBody2D

```
# v3
extends KinematicBody2D

# v4
extends CharacterBody2D
```

## Tween can be created in script

```
# v4
var tween = create_tween()
tween.tween_property($Sprite, "position", new_pos, 2.0)

# you can use a callback to do something after the tween ends
tween.tween_callback(func():
  # this runs after the tween completes
)
```


## V4 Tilemaps
Example Tutorials
- https://www.youtube.com/watch?v=tQSL2scuqeU


## Callables
Functions as a first class citizens

```
# v3
# todo

# v4
func _ready():
  foo.connect("basic_signal", my_function1)
  foo.connect("signal_with_args", my_function_2)

  # closure example
  foo.connect("basic_signal", func(): 
    my_function3("something to send")
  )

func my_function1():
  pass

func my_function2(a, b, c):
  pass

func my_function3(a):
  pass
```

## const dictionaries cannot be modified

```
# v3
const dict = {
  a = 1
}

# this is allowed
dict.a = 2

# v4
# must use var, const will give error
var dict = {
  a = 1
}
dict.a = 2
```