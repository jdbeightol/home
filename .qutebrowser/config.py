c.bindings.commands = {"command": {}, "insert": {"<Escape>": "leave-mode ;; jseval -q document.activeElement.blur()"}, "normal": {"J": "tab-prev", "K": "tab-next", "j": "scroll-px 0 200", "k": "scroll-px 0 -200"}}
c.editor.command = ["/usr/local/bin/kitty", "vim", "-f", "{file}", "-c", "normal {line}G{column0}l"]

# TODO: Experimenting with these to see if insert behavior becomes more predictable.
#c.input.insert_mode.auto_load = True
c.input.insert_mode.auto_enter = False
c.input.insert_mode.auto_leave = False
c.input.insert_mode.auto_load = False
c.input.insert_mode.plugins = False

c.scrolling.smooth = True
c.tabs.background = True
config.load_autoconfig()
config.source('theme.py')
