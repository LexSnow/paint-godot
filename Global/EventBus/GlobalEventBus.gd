@warning_ignore("unused_signal")
extends Node

## Emits: ColorOption
## Connects: ColorContainer
signal color_change_requested(color: Color)
## Emits: ShapeSelection
## Connects: PaintCanvas
signal shape_selected(shape_type: String)
## Emits: ModeSelection
## Connects: PaintCanvas
signal mode_selected(mode_type: String)
## Emits: EditSelection
## Connects: PaintCanvas
signal edit_mode_selected(edit_mode_type: String)
## Emits: DrawSelection
## Connects: PaintCanvas
signal draw_mode_selected(draw_mode_type: String)
signal shape_clicked(shape: Shape)
