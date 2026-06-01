import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxSprite;
import flixel.FlxG;

var whBar:FlxSprite;
var startX:Float = 0;

var lastPercent:Float = 0;
var currentTween:FlxTween;

function onCreate()
{
	// Hides the default Psych Engine loading bar so yours shows up cleanly
	barGroup.visible = false;

	// I swapped add() for addBehindBar() which is a special 1.0+ Loading Screen function
	// that ensures your custom graphics stay behind any vital system text.
	var lod = new FlxSprite(0, 0).loadGraphic(Paths.image('loading_screen/load'));
	lod.antialiasing = ClientPrefs.data.antialiasing;
	lod.setGraphicSize(FlxG.width, FlxG.height);
	lod.updateHitbox();
	lod.screenCenter();
	addBehindBar(lod);

	var blackBar = new FlxSprite(700, 65).makeGraphic(535, 50, 0xFF000000);
	addBehindBar(blackBar);

	whBar = new FlxSprite(713, 75).makeGraphic(510, 30, 0xFFFFFFFF);
	startX = whBar.x;
	whBar.origin.set(0, 0);
	whBar.scale.x = 0;
	addBehindBar(whBar);

	var blacktran = new FlxSprite(0, 0).makeGraphic(1280, 767, 0xFF000000);
	blacktran.setGraphicSize(FlxG.width, FlxG.height);
	blacktran.updateHitbox();
	blacktran.screenCenter();
	addBehindBar(blacktran);

	FlxTween.tween(blacktran, {alpha: 0}, 0.5, {
		ease: FlxEase.sineInOut
	});
}

function onUpdate(elapsed:Float)
{
	var loaded:Float = getLoaded();
	var maxLoad:Float = getLoadMax();

	var percent:Float = 0;

	if (maxLoad > 0)
		percent = loaded / maxLoad;

	percent = FlxMath.bound(percent, 0, 1);

	if (Math.abs(percent - lastPercent) > 0.01)
	{
		lastPercent = percent;

		if (currentTween != null)
			currentTween.cancel();

		currentTween = FlxTween.tween(whBar.scale, {x: percent * 1.16}, 0.25, {
			ease: FlxEase.sineOut
		});
	}

	whBar.x = startX;
}
