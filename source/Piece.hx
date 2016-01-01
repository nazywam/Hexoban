package source;
import flixel.FlxBasic;
import flixel.group.FlxGroup.FlxTypedGroup;

/**
 * ...
 * @author Michael
 */
class Piece extends FlxBasic{

	public var tiles:FlxTypedGroup<Tile>;
	public var pieceId:Int;
	
	public function new(i : Int) {
		super();
		
		pieceId = i;
		tiles = new FlxTypedGroup<Tile>();
	}
	
	public function addTile(x:Int, y:Int) {
		var t = new Tile(x, y, pieceId);
		t.color = 0xFFFF0000;
		tiles.add(t);
		
	}
}