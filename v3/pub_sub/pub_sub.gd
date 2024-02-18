extends Node

var _subscriptions = {}
var pending_events_buffer = []

func subscribe(event_key: String, listener) -> void:
  if !_subscriptions.has(event_key):
    _subscriptions[event_key] = []
    
  _subscriptions[event_key].append(listener)
  
func publish(event_key: String, payload = null) -> void:
  if !_subscriptions.has(event_key): return
  
  var listeners = _subscriptions[event_key] as Array
  for listener in listeners:    
    listener.call_func(payload)
    
# adds event to the buffer to be published when process_async_buffer is called
func publish_deferred(event_key: String, payload = null) -> void:
  if !_subscriptions.has(event_key): return
  
  pending_events_buffer.append([event_key, payload])

# publishes all events in the buffer. call from a _process loop
func process_deferred_buffer():
  while pending_events_buffer.size() > 0:
    var message_event = pending_events_buffer.pop_front()
    publish(message_event[0], message_event[1])

func clear_all():
  _subscriptions.clear()
