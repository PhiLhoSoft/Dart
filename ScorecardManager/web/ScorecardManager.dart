import 'package:polymer/polymer.dart';
import 'models.dart';

/**
 * Scorecard's manager.
 */
@CustomTag('scorecard-manager')
class ScorecardManager extends PolymerElement
{
	@observable Views views;

	ScorecardManager.created() : super.created()
	{
		IconRanges ic1 = new IconRanges(iconName: 'up-arrow', ranges: [ 1, 2 ]);
		IconRanges ic2 = new IconRanges(iconName: 'square', ranges: [ 3 ]);
		IconRanges ic3 = new IconRanges(iconName: 'down-arrow', ranges: [ 4, 5 ]);
		Scorecard sc1 = new Scorecard('One calculation', displayValues: true, iconRanges: [ ic1, ic2, ic3 ]);
		Scorecard sc2 = new Scorecard('One counter', iconRanges: [ic2]);
		Scorecard sc3 = new Scorecard('A formula', displayValues: true, iconRanges: [ ic1, ic3 ]);
		View view1 = new View("First")..scorecards = [ sc1, sc2, sc3 ];
		View view2 = new View("Second");
		View view3 = new View("Last");
		views = new Views()..views = [ view1, view2, view3 ];
	}

	@override bool get applyAuthorStyles => true;
}

