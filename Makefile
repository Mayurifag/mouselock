.ONESHELL:
.DEFAULT_GOAL := install
SHELL := /bin/bash
VERSION=$(shell git tag -l 'v*' --sort=-v:refname | head -1)

set-eu4-bundleidentifier:
ifneq ("$(wildcard ~/Library/Application\ Support/Steam/steamapps/common/Europa\ Universalis\ IV/eu4.app/Contents/Info.plist)","")
	@echo "Setting bundle identifier of your EU4 🎉"
	@/usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier com.paradox.eu4" ~/Library/Application\ Support/Steam/steamapps/common/Europa\ Universalis\ IV/eu4.app/Contents/Info.plist
else
	@echo "It seems you have installed EU4 not into default folder. Please, change path in Makefile" && exit 1
endif

set-version:
	@agvtool new-version ${VERSION}

clean-build:
	@rm -rf build

build: clean-build set-version
	@echo "Building release..."
	@xcodebuild -quiet -configuration Release -target mouselock &> /dev/null

dmg:
	@rm -rf dist && mkdir dist
	@echo "Making dmg release..."
	@hdiutil create -fs HFS+ -srcfolder build/Release/mouselock.app -volname mouselock dist/mouselock.dmg

release: build dmg

install: set-eu4-bundleidentifier build
	@cp -r build/Release/mouselock.app ~/Applications
	@echo "Mouselock is installed into ~/Applications. Change this in Makefile if you wanted to install somewhere else"

git:
	$(eval VERSION=$(shell git describe --tags --abbrev=0 | awk -F. '{OFS="."; $$NF+=1; print $0}'))
	git add .
	git commit -m "Bump version to ${VERSION}"
	git push origin main
	git tag -a $(VERSION) -m "new release"
	git push origin $(VERSION)

.PHONY: release install dmg build clean-build set-version set-eu4-bundleidentifier git
