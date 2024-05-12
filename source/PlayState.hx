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
	var xp:FlxSprite;
	var okHitBox:FlxSprite;
	var titlebarHitBox:FlxSprite;
	var brandonHitBox:FlxSprite;
	var closeButtonHitBox:FlxSprite;

	var inBio:Bool = false;

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

		makeUI();

		var discord = new XPWindow(5, 0, "discord", 200, 124, [-25, -5], [-48, 0]);
		discord.onButtonPress = function() {
			FlxG.openURL("https://discord.gg/MZkvWPW4");
		};
		add(discord);

		/*brandonHitBox = new FlxSprite(xp.x + 15, xp.y + 40).makeGraphic(38, 35);
			brandonHitBox.alpha = 0.75;
			add(brandonHitBox); */
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.justPressed)
		{
			if (FlxG.mouse.overlaps(xp))
				xp.animation.play("normal");
			else
				xp.animation.play("inactive");
		}

		if (FlxG.mouse.overlaps(okHitBox) && FlxG.mouse.justPressed)
		{
			xp.animation.play("buttonp1");
			xp.animation.finishCallback = function(n)
			{
				inBio = !inBio;
				makeUI();

				FlxG.sound.play('assets/sounds/xp-error.mp3', 1);

				xp.animation.finishCallback = function(n) {};
			};
		}

		if (FlxG.mouse.overlaps(closeButtonHitBox) && FlxG.mouse.justPressed)
		{
			xp.kill();
			okHitBox.kill();
			titlebarHitBox.kill();
			closeButtonHitBox.kill();
			inBio = false;
		}

		if (FlxG.mouse.overlaps(titlebarHitBox) && FlxG.mouse.pressed)
		{
			xp.setPosition(FlxG.mouse.x - 30, FlxG.mouse.y - 10);
			setHitboxPosition("box");
			setHitboxPosition("title");
			setHitboxPosition("close");
		}
	}

	function setHitboxPosition(type:String = "")
	{
		switch (type)
		{
			case "box":
				if (inBio)
					okHitBox.setPosition(xp.x + 180, xp.y + 344);
				else
					okHitBox.setPosition(xp.x + 89, xp.y + 93);
			case "title":
				titlebarHitBox.setPosition(xp.x, xp.y);
			case "close":
				if (inBio)
					closeButtonHitBox.setPosition(xp.x + 405, xp.y + 5);
				else
					closeButtonHitBox.setPosition(xp.x + 222, xp.y + 5);
			case "brandon":
				brandonHitBox.setPosition(xp.x + 15, xp.y + 40);
		}
	}

	function makeUI()
	{
		if (xp != null)
			xp.kill();
		if (okHitBox != null)
			okHitBox.kill();
		if (titlebarHitBox != null)
			titlebarHitBox.kill();
		if (closeButtonHitBox != null)
			closeButtonHitBox.kill();

		if (inBio)
		{
			xp = new FlxSprite(5).loadGraphic("assets/images/xpbio.png", true, 430, 380);
			xp.animation.add("normal", [0], 1, false); // box idle
			xp.animation.add("inactive", [1], 1, false); // box not pressed
			xp.animation.add("buttonp1", [3, 2, 3], 10, false); // pressed ok button
			xp.animation.play("normal");
		}
		else
		{
			xp = new FlxSprite(5).loadGraphic("assets/images/xp.png", true, 248, 129);
			xp.animation.add("hit", [0], 1, false); // owchieeeee 3;
			xp.animation.add("normal", [1], 1, false); // box idle
			xp.animation.add("inactive", [2], 1, false); // box not pressed
			xp.animation.add("buttonn1", [3], 1, false); // ok button idle
			xp.animation.add("buttonp1", [4, 3, 4], 10, false); // pressed ok button
			xp.animation.play("normal");
		}
		xp.antialiasing = true;
		xp.screenCenter(Y);
		add(xp);

		okHitBox = new FlxSprite().makeGraphic(71, 20);
		okHitBox.visible = false;
		add(okHitBox);

		titlebarHitBox = new FlxSprite().makeGraphic(Std.int(xp.width), 29);
		titlebarHitBox.visible = false;
		add(titlebarHitBox);

		closeButtonHitBox = new FlxSprite().makeGraphic(20, 20);
		closeButtonHitBox.visible = false;
		add(closeButtonHitBox);

		setHitboxPosition("box");
		setHitboxPosition("title");
		setHitboxPosition("close");
	}
}
