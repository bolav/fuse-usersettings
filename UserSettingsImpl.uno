using Uno;
using Uno.Collections;
using Fuse;
using iOS.Foundation;
using Android.android.content;
using Uno.Compiler.ExportTargetInterop;

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
	Java.Object native;

	public UserSettingsImpl () {
		Init();
	}

    [Foreign(Language.Java)]
    void Init()
    @{
        android.app.Activity ctx = com.fuse.Activity.getRootActivity();
        @{UserSettingsImpl:Of(_this).native:Set(ctx.getPreferences(android.content.Context.MODE_PRIVATE))};
    @}

    [Foreign(Language.Java)]
	public string GetString (string key)
    @{
        android.content.SharedPreferences p =
            (android.content.SharedPreferences)@{UserSettingsImpl:Of(_this).native:Get()};
		return p.getString(key, "");
	@}

    [Foreign(Language.Java)]
	public void SetString (string key, string val)
    @{
        android.content.SharedPreferences p =
            (android.content.SharedPreferences)@{UserSettingsImpl:Of(_this).native:Get()};
        android.content.SharedPreferences.Editor editor = p.edit();
		editor.putString(key, val);
		editor.commit();
	@}
}
