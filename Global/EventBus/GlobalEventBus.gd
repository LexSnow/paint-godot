@warning_ignore("unused_signal")
extends Node

## Emits:
## Connects: Shape
signal color_change_requested(color: Color)
## Emits:
## Connects: PaintCanvas
signal shape_selected(shape_type: Shape)