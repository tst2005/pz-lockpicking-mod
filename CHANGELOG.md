# Changelog

### Version 1.8.0

- Re-enable custom spawn points for the Burglar profession ([Closes #5](https://github.com/cyberbobjr/pz-lockpicking-mod/issues/5))

### Version 1.7.1

- Fixed [#8](https://github.com/cyberbobjr/pz-lockpicking-mod/issues/8) - Reduce amount of false positives for doors inside of houses

### Version 1.7.0

- Player's panic levels now affect the lockpicking success ([Closes #6](https://github.com/cyberbobjr/pz-lockpicking-mod/issues/6))
- Reduced the base chance for successfully picking a lock
- Fixed [#3](https://github.com/cyberbobjr/pz-lockpicking-mod/issues/3) - Lockpicking sound is now stopped correctly when the timed action Stops
- Fixed [#7](https://github.com/cyberbobjr/pz-lockpicking-mod/issues/7) - Timed Actions for breaking door and window locks now stop when the player walks or runs

### Version 1.6.1

- Make use of mod id

### Version 1.6.0

- Vanilla traits influence outcome and chances of the lockpicking / lockbreaking Actions ([Closes #4](https://github.com/cyberbobjr/pz-lockpicking-mod/issues/4))
    - "Clumsy" and "Graceful" will affect the noise of lockbreaking
    - "Lucky" and "Unlucky" will generally affect all random elements
    - "Keen Hearing" and "Hard Of Hearing" will affect the chance of successfully picking a lock
- Added support for automatic version checking ([Tiny AVC](https://github.com/blind-coder/pz-tiny_avc))
- Fixed translation encoding
- Fixed linebreaks trait description
- Cropped mod poster

### Version 1.5.0

- Added French translation
- Added recipe to craft a Bobby Pin from a Paperclip

### Version 1.4.1

- Adjusted the point cost for the Burglar Profession

### Version 1.4.0

- Merged the vanilla Burglar with the mod version

### Version 1.3.0

- Invalidate keys when a lock is broken during lockpicking attempt
- Fix empty tooltip on profession selection
- No longer check if a door is an exterior door, it was causing too many false negatives

### Version 1.2.0

- Updated for Build 31.8
- Fixed eating
- Fixed walking adjacent to door
- Fixed Burglar Profession

### Version 1.1.0

- Cut 4 seconds from lockpicking sound files
- Disabled 'setPermaLocked(true)' when you break the lock on a window. This caused you to not be able to climb through the window.
- Rewrote distribution methods

### Version 1.0.1

- Deactivated debug cheat

### Version 1.0.0

- Updated to Build 26 (only tested with SP)
- Fixed doors inside of houses displayed as locked
- Removed Utility-Mod dependencies

### Version 0.7.7

- Replaced burglar icon with updated version
- Fixed Bug caused by some test code
- Added poster.png

### Version 0.7.6

- Updated to work with the latest version of the modding utils
- Fixed Bug with Sound Manager
- Fixed Bug with Spawnpoints (Uses vanilla spawnpoints until the issue is fixed)
- Fixed Bug with Trait icons not showing up
- Added french translation by Galbar

### Version 0.7.5

- Added six new spawn points for Muldraugh
- Added four new spawn points for West Point
- Tweaked times for breaking / picking locks
- Fixed issue with broken items in inventory
- Removed breakpoint() call
- Added experimental translation just for fun

### Version 0.7.4

- Fixed potential crash

### Version 0.7.3

- Updated / Fixed: Muldraugh Profession Spawn

### Version 0.7.2

- Fixed: Open doors displayed as locked
- Fixed: Re-equipping two-handed items after lock-breaking
- Increased chances for failing to pick / break locks

### Version 0.7.1

- Added custom profession icon (thanks to nasKo)
- Nerfed Nimble Fingers trait a bit
- Fixed: missing function

### Version 0.7.0

- Added a few spawn points in West Point
- Added a second Bobby Pin (Texture by nasKo)
- Tweaked spawning rates and loot distribution.

### Version 0.6.1

- Fixed: Mod not loading due to 'require' calls
- Fixed: Spawn points in Muldraugh

### Version 0.6.0
- Updated for latest 64 bit interim build
- Added lockbreaking for windows
	- Locked windows can be forced open with crowbar
	- attracts zombies in a small radius
	- Failure leads to a smashed window (1:15 chance)
	- Uses custom sound
	- Windows get stuck when opened with a crowbar
- Added chance to lose the bobby pin when failing to pick a lock
- Added new crafting recipe which allows to make empty notebooks
- Player automatically equips the necessary items to perform the action and re-equips the previous items after performing the action
- Proper item damage (Uses same system as combat now)
- Added Burglar profession & Nimble Fingers trait
- Item texture for bobby pin is loaded correctly now
- Mod now also works with translated games
