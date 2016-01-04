package source;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxColor;

/**
 * ...
 * @author Michael
 */
class Tile extends FlxSprite {

	public var pos:FlxPoint;
	public var pieceID:Int;
	
	public function new(X:Int, Y:Int, I:Int) {
		var tmp = Settings.getPosition(X, Y);
		pos = FlxPoint.get(X, Y);
		
		super(tmp.x, tmp.y);
		loadGraphic("assets/images/Tile.png", true, 90, 106);
		animation.add("default", [I]);
		animation.play("default");
		
		pieceID = I;
	}
	
	public function updatePosition() {
		var tmp = Settings.getPosition(pos.x, pos.y);
		x = tmp.x;
		y = tmp.y;
	}
}