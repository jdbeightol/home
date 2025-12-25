from sys import platform

# old versions of qutebrowser used the "leave-mode" command; new versions switched
# to a more consistent "mode-leave" command; we need to re-assign escape based on
# whichever version of the mode leaving command we have
mode_leave = "mode-leave ;; jseval -q document.activeElement.blur()"
if c.bindings.default['insert']['<Escape>'] == "leave-mode":
    mode_leave = "leave-mode ;; jseval -q document.activeElement.blur()"

# set the correct version of the Ctrl or Command modifier for the operating system
ctrl_mod = "Ctrl"
if platform == "darwin":
    ctrl_mod = "Command"

# these custom bindings achieve the following:
# - ensure that we leave any text boxes when running mode-leave for
#   predictability when typing
# - to help with scrolling speed
# - switch J and K tab direction to be "left/right" rather than "up/down"
custom_commands = {
  "insert": {
    "<Escape>": mode_leave 
  },
  "normal": {
    "<Space>": "scroll-page 0 1",
    "<Shift-Space>": "scroll-page 0 -1",
    "J": "tab-prev",
    "K": "tab-next",
    "h": "scroll-px -200 0",
    "j": "scroll-px 0 200",
    "k": "scroll-px 0 -200",
    "l": "scroll-px 200 0",
    "<%s+c>" % ctrl_mod: "yank --quiet selection",
    "gy": "spawn --userscript youtube-download"
  }
}

# use the recommended `config.bind(...)` mechanism rather than setting the
# commands or default maps directly.
for mode in custom_commands:
    commands = custom_commands[mode]
    for key in commands:
        config.bind(key, commands[key], mode=mode)

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

# disable favicons in tabs because they're hard to see anyways
c.tabs.favicons.show = "never"

# try to make scrolling more visually tolerable since we changed scrolling 
# distances above
c.scrolling.smooth = True

# change how downloads display and are automatically removed
c.downloads.position = "bottom"
c.downloads.location.prompt = False
c.downloads.location.suggestion = "both"
c.downloads.remove_finished = 30000

# use all letters for hints and increase size
c.hints.chars = "asdfghjklqwertyuiopzxcvbnm"
c.fonts.hints = "bold 14pt default_family"

# set default search and start page to searxng
c.url.start_pages = "https://search.service.saturn.consul/"
c.url.searchengines = {
    "DEFAULT": "https://search.service.saturn.consul/search?q={}",
}

# disable notifications because they're annoying and other content blocking,
# but only if supported; fail silently
try:
    c.content.notifications.enabled = False

    with config.pattern('*://*.sol/*') as p:
        p.content.blocking.enabled = False

    with config.pattern('*://*.sol:*/*') as p:
        p.content.blocking.enabled = False

except:
    pass

# load autoconfig here to ensure local config overrides shared config --e.g.,
# to use leave-mode rather than mode-leave on v2.0+
config.load_autoconfig()

# apply the theme after loading autoconfig
config.source('theme.py')
