package;

import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.effects.FlxFlicker;
import flixel.util.FlxColor;

using StringTools;

class PlayState extends FlxState
{
	var xp:XPWindow;
	var discord:XPWindow;

	var bioWindowOpen:FlxSprite;
	var discordWindowOpen:FlxSprite;
	var bg2:FlxSprite;

	var dateText:FlxText;

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

		discord = new XPWindow(5, 0, "discord", 198, 124, [-25, -5], [-48, 0]);
		discord.onButtonPress = function()
		{
			FlxG.openURL("https://discord.gg/MZkvWPW4");
		};
		add(discord);

		xpNormal();

		var taskBar = new FlxSprite(0, FlxG.height * 0.94).makeGraphic(FlxG.width, 45, FlxColor.BLACK);
		add(taskBar);

		bioWindowOpen = new FlxSprite(10, taskBar.y - 5).loadGraphic("assets/images/bio-icon.png");
		add(bioWindowOpen);

		discordWindowOpen = new FlxSprite(bioWindowOpen.x + 54, bioWindowOpen.y).loadGraphic("assets/images/discord-icon.png");
		add(discordWindowOpen);

		dateText = new FlxText(0, taskBar.y, FlxG.width, "", 14);
		dateText.alignment = RIGHT;
		add(dateText);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		dateText.text = Date.now().toString().replace(" ", "\n");

		if (FlxG.mouse.overlaps(bioWindowOpen) && FlxG.mouse.justPressed)
		{
			if (!xp.alive)
				xpNormal();
			else
				xp.visible = !xp.visible;
		}

		if (FlxG.mouse.overlaps(discordWindowOpen) && FlxG.mouse.justPressed)
		{
			if (!discord.alive)
			{
				discord = new XPWindow(5, 0, "discord", 198, 124, [-25, -5], [-48, 0]);
				discord.onButtonPress = function()
				{
					FlxG.openURL("https://discord.gg/MZkvWPW4");
				};
				add(discord);
			}
			else
			{
				discord.visible = !discord.visible;
			}
		}
	}

	function xpNormal()
	{
		if (xp != null)
			xp.kill();

		xp = new XPWindow(5, 100, "", 289, 129, [20, 0], [41.5, 0]);
		xp.onButtonPress = xpBio;
		add(xp);
	}

	function xpBio()
	{
		if (xp != null)
			xp.kill();

		xp = new XPWindow(5, 100, "bio", 483, 354, [116, 226], [235, 0]);
		xp.onButtonPress = xpNormal;
		add(xp);
	}
}