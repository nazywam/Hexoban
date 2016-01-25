package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import source.PlayState;
import source.Tile;
import source.Settings;
/**
 * ...
 * @author Michael
 */
class LevelEditor extends FlxState {

	public var currentlyDragging:Tile;
	var background:Array<Array<Tile>>;

	override public function new() {
		super();
	}
	
	override public function create(){
		super.create();
		
		FlxG.camera.x = -Settings.TILE_SIZE / 2 +2;
		FlxG.camera.y = -Settings.TILE_SIZE - 6;
		FlxG.worldBounds.set( -Settings.TILE_SIZE, -Settings.TILE_SIZE, FlxG.width + Settings.TILE_SIZE, FlxG.height + Settings.TILE_SIZE);
		FlxG.camera.width = FlxG.width + Settings.TILE_SIZE;
		FlxG.camera.height = FlxG.height+ Settings.TILE_SIZE;
		
		var b = new FlxSprite(0, 0, "assets/images/Background.png");
		//add(b);
		
		background = new Array<Array<Tile>>();
		for (y in 0...20) {
			var b = new Array<Tile>();
			var cols = 7;
			if (y % 2 == 0) {
				cols++;	
			}
				
			for (x in 0...cols) {
				var t = new Tile(x, y, 1);
				b.push(t);
				add(t);
			}	
			background.push(b);
		}
		
		
		
	}
	
	override public function update(elapsed:Float) {
		super.update(elapsed);
		
		
		if (FlxG.mouse.justPressed) {
			currentlyDragging = new Tile(0, 0, 3);
			add(currentlyDragging);
		}
		
		if (FlxG.mouse.pressed) {
			currentlyDragging.x = FlxG.mouse.x - 90 / 2;
			currentlyDragging.y = FlxG.mouse.y - 106 / 2;
		}
		
		if (FlxG.mouse.justReleased) {
			var boardY = 0;
			var boardX = 0;
			
			for (y in 0...background.length) {

				for (x in 0...background[y].length) {
							trace("asdAS");

					if (FlxG.mouse.overlaps(background[y][x])) {
						boardX = Std.int(background[y][x].pos.x);
						boardY = Std.int(background[y][x].pos.y);
					}
				}
			}
			
			
			currentlyDragging.pos.x = boardX;
			currentlyDragging.pos.y = boardY;
			
			currentlyDragging.updatePosition();
			
		}
	}
}