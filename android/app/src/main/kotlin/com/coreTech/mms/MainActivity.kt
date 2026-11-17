package com.coretech.mms

import org.opentraa.pip.PipActivity

// PipActivity (a FlutterActivity) forwards onUserLeaveHint and
// onPictureInPictureModeChanged to the pip plugin: auto-enter on Android 8-11
// and reliable PiP state updates on every version.
class MainActivity : PipActivity()
