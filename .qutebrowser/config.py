from sys import platform

# old versions of qutebrowser used the "leave-mode" command; new versions switched
# to a more consistent "mode-leave" command; we need to re-assign escape based on
# whichever version of the mode leaving command we have
mode_leave = "mode-leave ;; jseval -q document.activeElement.blur()"
if c.bindings.default['insert']['<Escape>'] == "leave-mode":
    mode_leave = "leave-mode ;; jseval -q document.activeElement.blur()"

# load the correct version of Ctrl+C or Command+C.
copy_command = "<Command+c>"
if platform != "darwin":
    copy_command = "<Ctrl+c>"

# these custom bindings achieve the following:
# - ensure that we leave any text boxes when running mode-leave for
#   predictability when typing
# - to help with scrolling speed
# - switch J and K tab direction to be "left/right" rather than "up/down"
c.bindings.commands = {
  "command": {},
  "insert": {
    "<Escape>": mode_leave 
  },
  "normal": {
    "<Space>": "scroll-page 0 1",
    "<Shift-Space>": "scroll-page 0 -1",
    "J": "tab-prev",
    "K": "tab-next",
    "j": "scroll-px 0 200",
    "k": "scroll-px 0 -200",
    copy_command: "yank --quiet selection"
  }
}

# this is our editor command; it may not be portable since kitty isn't portable
c.editor.command = ["/usr/local/bin/kitty", "vim", "-f", "{file}", "-c", "normal {line}G{column0}l"]

# these input mode settings help make qutebrowser more predictable
c.input.insert_mode.auto_enter = False
c.input.insert_mode.auto_leave = False
c.input.insert_mode.auto_load = False
c.input.insert_mode.plugins = False

# this one prevents sites from interrupting typing while the page is still loading
c.input.insert_mode.leave_on_load = False

# this prevents accidental insertion when in normal mode
c.input.forward_unbound_keys = "none"

# load tabs in the foreground; we can use ;r for background loading
c.tabs.background = False

# make it so the last used input mode is restored when switching tabs
c.tabs.mode_on_change = "restore"

# disable favicons in tabs because they're hard to see anyways
c.tabs.favicons.show = "never"

# try to make scrolling more visually tolerable since we changed scrolling 
# distances above
c.scrolling.smooth = True

# change how downloads display and are automatically removed
c.downloads.position = "bottom"
c.downloads.remove_finished = 5000
c.downloads.location.suggestion = "both"

# disable notifications globally because they're annoying, but only if supported; fail silently
try:
    c.content.notifications.enabled = False
except:
    pass

# load autoconfig here to ensure local config overrides shared config --e.g.,
# to use leave-mode rather than mode-leave on v2.0+
config.load_autoconfig()

# apply the theme after loading autoconfig
config.source('theme.py')

