package source;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState {

	override public function create():Void {
		super.create();
		FlxG.switchState(new PlayState(0));
	}

}