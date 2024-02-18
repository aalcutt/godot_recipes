# PubSub

A utility script for publisher and subscribe functionality. Supports syncrhonous and asynchronous messaging.

  - [Synchronous](#synchronous)
  - [Deferred Publishing](#deferred-publishing)

## Synchronous

Synchonous messages are published and executed as called as any other function call. This is useful if you need something executed immediately and part of the current frame. Note that in larger scales synchronous publishing could affect performance as everything has to be executed for the current frame to complete.

1. Add the script as a global AutoLoad named `PubSub`.
2. Add listener by subscribing to an event by name and providing a callback function that will be executed:
```
func _ready():
  PubSub.subscribe("event_name", funcref(self, "on_event_name"))

func _on_event_name(payload):
  # do something with they payload here
```
3. Publish messages by providing the event name and passing a payload. The payload can be of any type.

```
PubSub.publish("event_name", {payload})
```


## Deferred Publishing

Deferred publshing, also known as asynchronous publishing, will queue the message to be executed on the next iteration of the `process_deferred_buffer` call. Deferred publishing should be used when you do not need the message to be processed in the current frame. 

1. Add the script as a global AutoLoad named `PubSub`.
2. Call the buffer processing somewhere early in the main `_process()` loop.
```
func _process(delta):
  PubSub.process_deferred_buffer()
```
3. Add listener by subscribing to an event by name and providing a callback function that will be executed:
```
func _ready():
  PubSub.subscribe("event_name", funcref(self, "on_event_name"))

func _on_event_name(payload):
  # do something with they payload here
```
4. Publish messages by providing the event name and passing a payload. The payload can be of any type.

```
func my_function():
  PubSub.publish_deferred("event_name", {payload})
```

## Multiple PubSub Instances
In complex projects it might be beneficial to define multiple separate PubSub instances.

1. Add multiple separate global AutoLoads. Such as `UIPubSub`, `PlayerPubSub`, `WorldPubSub`. The naming and use cases is up to you.


### Insantiate
The simplest way to use this script is by adding it as a global AutoLoad. You can also instantiate a new instance of the script locally if 

## Notes
1. Synchronous and deferred publishing can be used interchangably. You can call and event synchronous in one place and deferred in another.