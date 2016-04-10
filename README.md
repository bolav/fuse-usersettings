Fuse User Settings
==================

Simple user settings [Fuse](http://www.fusetools.com/), using NSUserDefaults in iOS, and SharedPreferences for Android.

## Installation

Using [fusepm](https://github.com/bolav/fusepm)

    $ fusepm install https://github.com/bolav/fuse-usersettings


## Usage

In UX:

    <UserSettings ux:Global="UserSettings" />

In JavaScript:

    var settings = require('UserSettings');
    settings.setString('key', 'value');
    var val = settings.getString('key', 'default return');

