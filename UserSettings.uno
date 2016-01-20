using Uno;
using Uno.Collections;
using Fuse;
using Fuse.Scripting;

public class UserSettings : NativeModule {

	UserSettingsImpl _us;
	public UserSettings()
	{
		_us = new UserSettingsImpl();
		if defined(iOS) {
			AddMember(new NativeFunction("getString", (NativeCallback)iOSGetString));
			AddMember(new NativeFunction("setString", (NativeCallback)iOSSetString));
		}
		if defined(Android) {
			AddMember(new NativeFunction("getString", (NativeCallback)AndroidGetString));
		}
	}
	extern(iOS) public object iOSGetString(Context c, object[] args) {
		var key = args[0] as string;
		return _us.GetString(key);
	}
	extern(iOS) public object iOSSetString(Context c, object[] args) {
		var key = args[0] as string;
		var val = args[1] as string;
		_us.SetString(key, val);
		return null;
	}

	extern(Android) public object AndroidGetString(Context c, object[] args) {
		var key = args[0] as string;
		return _us.GetString(key);
	}

}
