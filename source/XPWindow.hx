package;

import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxSprite;

using StringTools;

class XPWindow extends FlxSprite
{
	public var titlebarHitBox:FlxSprite;
	public var closeButtonHitBox:FlxSprite;
	public var okHitBox:FlxSprite;
	public var closeHitboxOffset:Array<Float> = [0, 0];
	public var buttonHitboxOffset:Array<Float> = [0, 0];

	override public function new(x:Float = 5, y:Float = 0, image:String = "", width:Int = 248, height:Int = 129, buttonHitboxOffset:Array<Float>, closeHitboxOffset:Array<Float>, windowAlpha:Float = 1)
	{
		super(x, y);

		this.closeHitboxOffset = closeHitboxOffset;
		this.buttonHitboxOffset = buttonHitboxOffset;

		this.loadGraphic("assets/images/xp" + image + ".png", true, width, height);
		this.animation.add("normal", [0], 1, false); // box idle
		this.animation.add("inactive", [1], 1, false); // box not pressed
		this.animation.add("buttonp1", [3, 2, 3], 2, false); // pressed ok button
		this.animation.play("normal");
		this.alpha = windowAlpha;

		titlebarHitBox = new FlxSprite(this.x, this.y).makeGraphic(Std.int(this.width), 29);
		titlebarHitBox.visible = false;
		FlxG.state.add(titlebarHitBox);

		closeButtonHitBox = new FlxSprite(this.x + 222 + closeHitboxOffset[0], this.y + 5 + closeHitboxOffset[1]).makeGraphic(20, 20);
		closeButtonHitBox.visible = false;
		FlxG.state.add(closeButtonHitBox);

		okHitBox = new FlxSprite(this.x + 89 + buttonHitboxOffset[0], this.y + 93 + buttonHitboxOffset[1]).makeGraphic(71, 20);
		FlxG.state.add(okHitBox);
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.mouse.justPressed && !this.animation.curAnim.name.contains("button"))
		{
			if (FlxG.mouse.overlaps(this))
				this.animation.play("normal");
			else
				this.animation.play("inactive");
		}

		if (FlxG.mouse.overlaps(okHitBox) && FlxG.mouse.justPressed)
		{
			this.animation.play("buttonp1");

			onButtonPress();

			FlxG.sound.play('assets/sounds/xp-error.mp3', 1, false, null, true, function() {
				this.animation.play("normal");
			});

			/*this.animation.finishCallback = function(n)
			{
				FlxG.sound.play('assets/sounds/xp-error.mp3', 1);

				this.animation.finishCallback = function(n) {};
			}; //had to comment this out due to trashy ass bugs smh*/
		}

		if (FlxG.mouse.overlaps(closeButtonHitBox) && FlxG.mouse.justPressed)
			this.kill();

		if (FlxG.mouse.overlaps(titlebarHitBox) && FlxG.mouse.pressed)
		{
			this.setPosition(FlxG.mouse.x - 30, FlxG.mouse.y - 10);
			titlebarHitBox.setPosition(this.x, this.y);
			closeButtonHitBox.setPosition(this.x + 222 + closeHitboxOffset[0], this.y + 5 + closeHitboxOffset[1]);
			okHitBox.setPosition(this.x + 89 + buttonHitboxOffset[0], this.y + 93 + buttonHitboxOffset[1]);
		}
	}

	override public function kill()
	{
		super.kill();

		titlebarHitBox.kill();
		closeButtonHitBox.kill();
		okHitBox.kill();
	}

	dynamic public function onButtonPress() {
		trace("no code UwU");
	}
}
