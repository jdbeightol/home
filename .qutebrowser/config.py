# these custom bindings achieve the following:
# - ensure that we leave any text boxes when running mode-leave for
#   predictability
# - to help with scrolling
# - switch J and K tab direction to be "left/right" rather than "up/down"
c.bindings.commands = {
  "command": {},
  "insert": {
    "<Escape>": "mode-leave ;; jseval -q document.activeElement.blur()"
  },
  "normal": {
    "J": "tab-prev",
    "K": "tab-next",
    "j": "scroll-px 0 200",
    "k": "scroll-px 0 -200"
  }
}

# this is our editor command; it may not be portable since kitty isn't portable
c.editor.command = ["/usr/local/bin/kitty", "vim", "-f", "{file}", "-c", "normal {line}G{column0}l"]

# these input mode settings help make qutebrowser more predictable
c.input.insert_mode.auto_enter = False
c.input.insert_mode.auto_leave = False
c.input.insert_mode.auto_load = False
c.input.insert_mode.plugins = False

# load tabs in the foreground; we can use ;r for background loading
c.tabs.background = False

# try to make scrolling more visually tolerable since we changed scrolling 
# distances above
c.scrolling.smooth = True

# load autoconfig here to ensure local config overrides shared config --e.g.,
# to use leave-mode rather than mode-leave on v2.0+
config.load_autoconfig()

# apply the theme after loading autoconfig
config.source('theme.py')

