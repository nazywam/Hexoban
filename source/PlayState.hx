package source;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.FlxPointer;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import haxe.rtti.XmlParser;
import source.*;
import openfl.Assets;


class PlayState extends FlxState {
	
	var boardSize:Int = 7;
	
	var boardDirection:Int = -1;
	
	var background:Array<Array<Tile>>;
	var tiles:Array<Array<Tile>>;
	var pieces:Array<Piece>;
	
	var swypeBegin:FlxPoint;
	
	override public function create():Void {
		super.create();
		
		tiles = new Array<Array<Tile>>();
		background = new Array<Array<Tile>>();
		
		pieces = new Array<Piece>();
		
		swypeBegin = FlxPoint.get(0, 0);
		
		for (y in 0...boardSize) {
			tiles[y] = new Array<Tile>();
			background[y] = new Array<Tile>();
			for (x in 0...Settings.BOARD_SIZE) {
				tiles[y].push(null);
				background[y].push(null);
			}
		}
		loadLevel("assets/data/map.tmx");
		for (p in pieces) {
			for (t in p.tiles) {
				add(t);
			}
		}
		
		tick();
	}

	function getPiece(ID:Int) {
		for (p in pieces) {
			if (p.pieceId == ID) return p;
		}
		return null;
	}
	
	function loadLevel(path:String) {
		var data = Xml.parse(Assets.getText(path)).firstElement();
		var _tiles = data.elementsNamed("layer").next().elementsNamed("data").next().elementsNamed("tile");
		var _tileNumber = 0;
		
		for (t in _tiles) {
			var tileID = Std.parseInt(t.get("gid"))-1;
			if (tileID != -1) {
				
				var boardX:Int = _tileNumber % Settings.BOARD_SIZE;
				var boardY:Int = Std.int(_tileNumber / Settings.BOARD_SIZE);
				
				if (tileID != 0 && tileID != 1) {
					
					if (getPiece(tileID) == null) {
						var p = new Piece(tileID);
						pieces.push(p);
					}
					tiles[boardY][boardX] = getPiece(tileID).addTile(boardX, boardY);
					
					var t = new Tile(boardX, boardY, 1);
					background[boardY][boardX] = t;
					add(t);
					_tileNumber++;
				} else {
					var t = new Tile(boardX, boardY, tileID);
					background[boardY][boardX] = t;
					add(t);
					_tileNumber++;
				}
				
				
			}
		}
	}

		
	function tick() {
		for (p in pieces) {
			var canFall:Bool = true;
			
			for (t in p.tiles) {
				if (!Settings.nextPositionExists(t.pos.x, t.pos.y, boardDirection)) {
					canFall = false;
					break;
				}
				var nextPos = Settings.getNextPosition(t.pos.x, t.pos.y, boardDirection);
				
				if (nextPos.x == -1) {
					canFall = false;
					break;
				}
				if (tiles[Std.int(nextPos.y)][Std.int(nextPos.x)] != null && tiles[Std.int(nextPos.y)][Std.int(nextPos.x)].pieceID != t.pieceID) {
					canFall = false;
					break;
				}
				if (background[Std.int(nextPos.y)][Std.int(nextPos.x)].pieceID == 0) {
					canFall = false;
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
	
		#if mobile
			if (FlxG.touches.getFirst() != null && FlxG.touches.getFirst().justPressed) {
				swypeBegin.set(FlxG.touches.getFirst().screenX, FlxG.touches.getFirst().screenY);	
			}
		#else
			if (FlxG.mouse.justPressed) {
				swypeBegin.set(FlxG.mouse.x, FlxG.mouse.y);
			}
		#end
		
		
		#if mobile
		if (FlxG.touches.getFirst() != null && FlxG.touches.getFirst().justReleased) { 
		#else
		if (FlxG.mouse.justReleased) { // <3 God bless this code
		#end
			
			#if mobile
				var travelX = FlxG.touches.getFirst().screenX - swypeBegin.x;
				var travelY = -(FlxG.touches.getFirst().screenY - swypeBegin.y);
			#else
				var travelX = FlxG.mouse.x - swypeBegin.x;
				var travelY = -(FlxG.mouse.y - swypeBegin.y);
			#end
			
			var atan2 = (Math.atan2(travelY, travelX) + Math.PI);
			
			atan2 = (atan2 - Math.PI / 6 + Math.PI * 2) % (Math.PI * 2);
			var direction = Std.int(atan2 / (Math.PI / 3));
				
			switch(direction) {
				case 0:
					boardDirection = 1;
				case 1:
					boardDirection = 3;
				case 2:
					boardDirection = 6;
				case 3:
					boardDirection = 9;
				case 4:
					boardDirection = 7;
				case 5:
					boardDirection = 4;
			}
		}
		
		
		#if !mobile
		
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
		#end
	}
}