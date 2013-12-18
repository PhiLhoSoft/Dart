import 'package:polymer/polymer.dart';
import 'models.dart';

/**
 * Scorecard view list.
 */
@CustomTag('view-list')
class ViewList extends PolymerElement
{
	@observable Views views;

	ViewList.created() : super.created() {}
}

