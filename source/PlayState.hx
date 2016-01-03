package source;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import source.*;

class PlayState extends FlxState {
	
	var boardSize:Int = 7;
	
	var boardDirection:Int = -1;
	
	var background:Array<Array<Tile>>;
	var tiles:Array<Array<Tile>>;
	var pieces:FlxTypedGroup<Piece>;
	
	var map = "0011110011111001111111111111011111101111100011110";
	
	override public function create():Void {
		super.create();
		
		tiles = new Array<Array<Tile>>();
		background = new Array<Array<Tile>>();
		
		pieces = new FlxTypedGroup<Piece>();
		add(pieces);
		
		for (y in 0...boardSize) {
			tiles[y] = new Array<Tile>();
			background[y] = new Array<Tile>();
			for (x in 0...boardSize) {
				var t = new Tile(x, y, -1, map.charAt(y*boardSize+x) == '1');
				add(t);
				//add(t.t);
				background[y].push(t);
			}
		}
		
		var p = new Piece(0);
		add(p.tiles);
		pieces.add(p);
		
		p.addTile(0, 0);
		p.addTile(0, 1);
		p.addTile(1, 1);
		
		tiles[0][0] = p.tiles.members[0];
		tiles[0][1] = p.tiles.members[1];
		tiles[1][1] = p.tiles.members[2];
		
		tick();
	}

	function tick() {
		for (p in pieces) {
			var canFall:Bool = true;
			
			for (t in p.tiles) {
				if (!Settings.nextPositionExists(t.pos.x, t.pos.y, boardDirection)) {
					canFall = false;
					trace("!exists");
					break;
				}
				
				var nextPos = Settings.getNextPosition(t.pos.x, t.pos.y, boardDirection);
				
				if (nextPos.x == -1) {
					canFall = false;
					break;
				}
				
				if (tiles[Std.int(nextPos.y)][Std.int(nextPos.x)] != null &&  tiles[Std.int(nextPos.y)][Std.int(nextPos.x)].pieceID != t.pieceID) {
					canFall = false;
					trace("nexPosNotNull");
					break;
				}
			}
			
			if (canFall) {
				for (t in p.tiles) {
					var nextPos = Settings.getNextPosition(t.pos.x, t.pos.y, boardDirection);
					
					tiles[Std.int(t.pos.y)][Std.int(t.pos.x)] = null;
					tiles[Std.int(nextPos.y)][Std.int(nextPos.x)] = t;
					t.pos.x = nextPos.x;
					t.pos.y = nextPos.y;
					t.updatePosition();
				}
			}
			
			
		}
		
		
		var t = new FlxTimer();
		t.start(.1, function(_) { tick(); } );
	}

	
	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		
		if (FlxG.keys.justPressed.NUMPADONE || FlxG.keys.justPressed.Z) {
			boardDirection = 1;
		}
		if (FlxG.keys.justPressed.NUMPADTHREE || FlxG.keys.justPressed.C) {
			boardDirection = 3;
		}
		if (FlxG.keys.justPressed.NUMPADFOUR || FlxG.keys.justPressed.A) {
			boardDirection = 4;
		}
		if (FlxG.keys.justPressed.NUMPADSIX || FlxG.keys.justPressed.D) {
			boardDirection = 6;
		}
		if (FlxG.keys.justPressed.NUMPADSEVEN || FlxG.keys.justPressed.Q) {
			boardDirection = 7;
		}
		if (FlxG.keys.justPressed.NUMPADNINE || FlxG.keys.justPressed.E) {
			boardDirection = 9;
		}
	}
}