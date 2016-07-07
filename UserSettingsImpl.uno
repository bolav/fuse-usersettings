using Uno;
using Uno.Collections;
using Fuse;
using Uno.Compiler.ExportTargetInterop;

extern (!iOS && !Android) public class UserSettingsImpl
{
	static Dictionary<string,string> settings = new Dictionary<string,string>();

	public UserSettingsImpl () {}
	public string GetString (string key) {
		string val;
		settings.TryGetValue(key, out val);
		return val;
	}
	public void SetString (string key, string val) {
		settings[key] = val;
	}
}

extern(iOS) public class UserSettingsImpl
{
	public UserSettingsImpl () {
	}

	[Foreign(Language.ObjC)]
	public string GetString (string key)
	@{
		NSString *val = [[NSUserDefaults standardUserDefaults] stringForKey:key];
		return val;
	@}

	[Foreign(Language.ObjC)]
	public void SetString (string key, string val)
	@{
		[[NSUserDefaults standardUserDefaults] setObject:val forKey:key];
		[[NSUserDefaults standardUserDefaults] synchronize];
	@}

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
