using Uno;
using Uno.Collections;
using Fuse;
using iOS.Foundation;
using Android.android.content;

extern (!iOS && !Android) public class UserSettingsImpl
{
}

extern(iOS) public class UserSettingsImpl
{
	NSUserDefaults native;
	public UserSettingsImpl () {
		native = NSUserDefaults._standardUserDefaults();
		// native = new NSUserDefaults();
		// native.init();
	}

	public string GetString (string key) {
		return native.stringForKey(key);
	}

	public void SetString (string key, string val) {
		var str = new NSString();
		str.initWithString(val);
		native.setObjectForKey(str, key);
	}

}

extern(Android) public class UserSettingsImpl
{
	SharedPreferences native;
	public UserSettingsImpl () {
		var ctx = Android.android.app.Activity.GetAppActivity();
		native = ctx.getPreferences(Context.MODE_PRIVATE);
		// native = new NSUserDefaults();
		// native.init();
	}

	public string GetString (string key) {
		return native.getString(key, "");
	}

}