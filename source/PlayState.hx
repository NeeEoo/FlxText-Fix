package;

import openfl.system.System;
import flixel.util.FlxColor;
import flixel.graphics.FlxGraphic;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	var nonFixed:FlxNonFixedText;
	var fixedText:FlxFixedText;

	var ram:FlxFixedText;
	var rambf:FlxFixedText;
	var ramaf:FlxFixedText;

	override public function create():Void
	{
		//FlxGraphic.defaultPersist = true;

		var halfWidth = Std.int(FlxG.width / 2);

		var header = new FlxFixedText(0, 70, halfWidth, "Before Fix");
		header.size = 16;
		header.alignment = CENTER;
		add(header);
		var header = new FlxFixedText(halfWidth, 70, halfWidth, "After Fix");
		header.size = 16;
		header.alignment = CENTER;
		add(header);

		ram = new FlxFixedText(0, FlxG.height - 50, FlxG.width, "0 bytes");
		ram.size = 16;
		ram.alignment = CENTER;
		add(ram);
		rambf = new FlxFixedText(0, FlxG.height - 50, halfWidth, "0");
		rambf.size = 16;
		rambf.alignment = CENTER;
		add(rambf);
		ramaf = new FlxFixedText(halfWidth, FlxG.height - 50, halfWidth, "0");
		ramaf.size = 16;
		ramaf.alignment = CENTER;
		add(ramaf);

		nonFixed = new FlxNonFixedText(0, 0, halfWidth, "");
		nonFixed.cacheKey = "b";
		nonFixed.setFormat("VCR OSD Mono", 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		nonFixed.scrollFactor.set();
		nonFixed.borderSize = 1.25;
		nonFixed.screenCenter(Y);

		fixedText = new FlxFixedText(halfWidth, 0, halfWidth, "");
		fixedText.cacheKey = "a";
		fixedText.setFormat("VCR OSD Mono", 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		fixedText.scrollFactor.set();
		fixedText.borderSize = 1.25;
		fixedText.screenCenter(Y);

		add(nonFixed);
		add(fixedText);
	}

	var frame = 0;

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		frame++;

		if(!FlxG.keys.pressed.B) {
			nonFixed.text = Std.string(frame);
		}
		if(!FlxG.keys.pressed.A) {
			fixedText.text = Std.string(frame);
		}
		
		/*var ramBeforeFix = 0;
		var ramFix = 0;

		var cache = @:privateAccess FlxG.bitmap._cache;

		for(name => item in cache) {
			if(name.charAt(0) == "b") {
				ramBeforeFix += item.width * item.height * 4;
			}
			else if(name.charAt(0) == "a") {
				ramFix += item.width * item.height * 4;
			}
			//trace(name);
		}*/

		rambf.text = Std.string(nonFixed.totalGenerated);
		ramaf.text = Std.string(fixedText.totalGenerated);

		ram.text = Std.string(Math.floor(System.totalMemory / 1024)) + " kb";

		// Requires FlxGraphic.defaultPersist = true;
		//rambf.text = Std.string(Math.floor(ramBeforeFix / 1024 * 1000) / 1000) + " kb";
		//ramaf.text = Std.string(Math.floor(ramFix / 1024 * 1000) / 1000) + " kb";
	}
}