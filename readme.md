<h1 align="center">
  mouselock (forked to support Europa Universalis IV)
</h1>

<p align="center">
  <a href="https://github.com/Mayurifag/mouselock/releases/latest">
    <img src="https://img.shields.io/github/v/release/Mayurifag/mouselock"/>
  </a>
  <br>
  Lock mouse cursor to a centered area of the screen for MacOS.
  <br>
  <img src="screenshot.png"/>
</p>

## TL;DR

```sh
git clone https://github.com/Mayurifag/mouselock.git && cd mouselock
make install
```

This will set your eu4 bundle identifier; build project and install into
~/Applications. You'll need all the XCode stuff for that.

## Why?

In LoL, EU4 (and potentially other games), the cursor is not locked properly in borderless mode. This app and some tricky scripts are trying to fix that.

Also, `Makefile` script sets the bundle identifier for EU4 app, because its missing.

## Requirements

Requires MacOS 11.0 or later.

## Tips

- Get [LinearMouse](https://linearmouse.org) to remove mouse acceleration.
