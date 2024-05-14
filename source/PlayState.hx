package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.effects.FlxFlicker;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var bg2:FlxSprite;
	var xp:XPWindow;

	override public function create()
	{
		super.create();

		var bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFFFF7700);
		add(bg);

		bg2 = FlxGridOverlay.create(15, 15, 9999, 9999);
		bg2.alpha = 0.35;
		bg2.color = 0xFF3B3B3B;
		bg2.velocity.set(-12, -12);
		add(bg2);

		var discord = new XPWindow(5, 0, "discord", 198, 124, [-25, -5], [-48, 0]);
		discord.onButtonPress = function() {
			FlxG.openURL("https://discord.gg/MZkvWPW4");
		};
		add(discord);

		xpNormal();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function xpNormal() {
		if (xp != null)
			xp.kill();

		xp = new XPWindow(5, 100, "", 289, 129, [20, 0], [41.5, 0]);
		xp.onButtonPress = xpBio;
		add(xp);
	}

	function xpBio() {
		if (xp != null)
			xp.kill();

		xp = new XPWindow(5, 100, "bio", 483, 354, [116, 226], [235, 0]);
		xp.onButtonPress = xpNormal;
		add(xp);
	}
}