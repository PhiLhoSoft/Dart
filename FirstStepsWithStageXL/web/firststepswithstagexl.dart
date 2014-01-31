import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

void main()
{
	// Setup the Stage and RenderLoop
	var canvas = html.querySelector('#stage');
	var stage = new Stage(canvas);
	var renderLoop = new RenderLoop();
	renderLoop.addStage(stage);

	// Draw a red circle
	var shape = new Shape();
	shape.graphics.circle(canvas.clientWidth / 2, canvas.clientHeight / 2, 60);
	shape.graphics.fillColor(Color.AliceBlue);
	stage.addChild(shape);
}
