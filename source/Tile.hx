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
	public var t:FlxText;
	public var pieceID:Int;
	public var exist:Bool;
	
	public function new(X:Int, Y:Int, I:Int, e:Bool) {
		var tmp = Settings.getPosition(X, Y);
		pos = FlxPoint.get(X, Y);
		
		super(tmp.x, tmp.y, "assets/images/Tile.png");
		
		t = new FlxText(tmp.x + Settings.TILE_SIZE / 2, tmp.y + Settings.TILE_SIZE / 2, 0, Std.string(Y)+":"+Std.string(X));
		t.color = FlxColor.BLUE;
		t.size = 32;
		
		pieceID = I;
		exist = e;
		
		visible = exist;
		
		
	}
	
	public function updatePosition() {
		var tmp = Settings.getPosition(pos.x, pos.y);
		x = tmp.x;
		y = tmp.y;
	}
}