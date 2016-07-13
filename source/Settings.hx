package source;
import flixel.math.FlxPoint;

/**
 * ...
 * @author Michael
 */
class Settings {

	public static var TILE_SIZE:Int = 52;
	public static var BOARD_SIZE:Int = 7;
	public static var BOARD_OFFSET:FlxPoint = FlxPoint.get(24, 60);
	public static var TICK_LENGTH:Float = .07;

	public static function getPosition(x:Float, y:Float):FlxPoint {
		var height = Math.round(Settings.TILE_SIZE * (Math.sqrt(3) - (Math.sqrt(3) - 1) / 4));
		var posX:Float = x * Settings.TILE_SIZE * Math.sqrt(3);
		var posY:Float = y * height;
		if (y % 2 == 1) {
			posX += Settings.TILE_SIZE * Math.sqrt(3) / 2;
		}	
		
		return FlxPoint.get(posX + BOARD_OFFSET.x, posY + BOARD_OFFSET.y);
	}

	public static function nextPositionExists(x:Float, y:Float, direction:Int):Bool {
		switch(direction) {
			case 1:
				if ((x == 0 && y % 2 == 0) || y == Settings.BOARD_SIZE-1) return false;
			case 3:
				if ((x == BOARD_SIZE-1 && y % 2 == 1) || y == BOARD_SIZE-1) return false;
			case 4:
				if (x == 0) return false;
			case 6:
				if (x == BOARD_SIZE-1) return false;
			case 7:
				if ((x == 0 && y % 2 == 0) || y == 0) return false;
			case 9:
				if ((x == BOARD_SIZE-1 && y % 2 == 1) || y == 0) return false;
		}
		return true;
	}
	
	public static function getNextPosition(x:Float, y:Float, direction:Int):FlxPoint {
	
		if (y % 2 == 0) {
			switch(direction) {
				case 1:
					return FlxPoint.get(x - 1, y + 1);
				case 3:
					return FlxPoint.get(x, y + 1);
				case 4:
					return FlxPoint.get(x - 1, y);
				case 6:
					return FlxPoint.get(x + 1, y);
				case 7:
					return FlxPoint.get(x - 1, y - 1);
				case 9:
					return FlxPoint.get(x, y - 1);
			}
		} else {
			switch(direction) {
				case 1:
					return FlxPoint.get(x, y + 1);
				case 3:
					return FlxPoint.get(x + 1, y + 1);
				case 4:
					return FlxPoint.get(x - 1, y);
				case 6:
					return FlxPoint.get(x + 1, y);
				case 7:
					return FlxPoint.get(x, y - 1);
				case 9:
					return FlxPoint.get(x + 1, y - 1);
			}	
		}
		return FlxPoint.get( -1, -1);
	}
}