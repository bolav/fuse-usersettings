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
			AddMember(new NativeFunction("setString", (NativeCallback)AndroidSetString));
		}
		if defined(!Android && !iOS) {
			AddMember(new NativeFunction("getString", LocalGetString));
			AddMember(new NativeFunction("setString", LocalSetString));
		}
	}

	// iOS
	extern(iOS) public object iOSGetString(Context c, object[] args) {
		var key = args[0] as string;
		var val = _us.GetString(key);
		if (val == null && args.Length > 1) {
			val = args[1] as string;
		}
		return val;
	}
	extern(iOS) public object iOSSetString(Context c, object[] args) {
		var key = args[0] as string;
		var val = args[1] as string;
		_us.SetString(key, val);
		return null;
	}

	// Android
	extern(Android) public object AndroidGetString(Context c, object[] args) {
		var key = args[0] as string;
		var val = _us.GetString(key);
		if (val == null && args.Length > 1) {
			val = args[1] as string;
		}
		return val;
	}
	extern(Android) public object AndroidSetString(Context c, object[] args) {
		var key = args[0] as string;
		var val = args[1] as string;
		_us.SetString(key, val);
		return null;
	}

	// Local
	extern public object LocalGetString(Context c, object[] args) {
		var key = args[0] as string;
		var val = _us.GetString(key);
		if (val == null && args.Length > 1) {
			val = args[1] as string;
		}
		return val;
	}
	extern public object LocalSetString(Context c, object[] args) {
		var key = args[0] as string;
		var val = args[1] as string;
		_us.SetString(key, val);
		return null;
	}
}
