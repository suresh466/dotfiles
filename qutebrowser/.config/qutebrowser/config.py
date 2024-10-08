import dracula.draw

config.load_autoconfig()

c.tabs.background = True
c.new_instance_open_target = "window"
c.downloads.position = "bottom"
# c.spellcheck.languages = ['en-US']

config.bind(",ce", "config-edit")
config.bind(",p", "config-cycle -p content.plugins ;; reload")

config.bind(",rta", "open {url}top/?sort=top&t=all")
config.bind(",rtv", 'spawn alacritty -e "rtv {url}"')
config.bind(",f", "spawn -d firefox {url}")
config.bind(",c", "spawn -d chromium {url}")

# Keyboardio
config.bind("<Shift-Left>", "back")
config.bind("<Shift-Down>", "tab-next")
config.bind("<Shift-Up>", "tab-prev")
config.bind("<Shift-Right>", "forward")

c.url.searchengines["rfc"] = "https://tools.ietf.org/html/rfc{}"
c.url.searchengines["pypi"] = "https://pypi.org/project/{}/"
c.url.searchengines["qtbug"] = "https://bugreports.qt.io/browse/QTBUG-{}"
c.url.searchengines["qb"] = "https://github.com/The-Compiler/qutebrowser/issues/{}"
c.url.searchengines["btc"] = "https://www.blockchain.com/btc/address/{}"
c.url.searchengines["http"] = "https://httpstatuses.com/{}"
c.url.searchengines["duden"] = "https://www.duden.de/suchen/dudenonline/{}"
c.url.searchengines["dictcc"] = "https://www.dict.cc/?s={}"
# c.url.searchengines['maps'] = 'https://www.google.com/maps?q=%s'
c.url.searchengines["y"] = "https://www.youtube.com/results?search_query={}"
c.url.searchengines["g"] = "https://www.google.com/search?q={}"
c.url.searchengines["b"] = "https://search.brave.com/search?q={}"
c.url.searchengines["DEFAULT"] = "https://search.brave.com/search?q={}"

c.aliases["ytdl"] = """spawn -v -m bash -c 'cd ~/vid/yt && youtube-dl "$@"' _ {url}"""

c.fonts.default_family = "Hack Nerd Font"
c.fonts.default_size = "10pt"  # 10

c.fonts.web.size.default = 20  # 18
c.fonts.web.size.default_fixed = 17  # 15

c.fonts.hints = "bold 15px default_family"

c.search.incremental = True
c.editor.command = ["code", "-nw", "{}"]

# c.qt.args = ['ppapi-widevine-path=/usr/lib/qt/plugins/ppapi/libwidevinecdmadapter.so']

c.content.javascript.enabled = False
config.set("content.javascript.clipboard", "access", "https://chatgpt.com")
config.set("content.javascript.clipboard", "access", "https://claude.ai")
config.set("content.javascript.clipboard", "access", "https://github.com")

# Dark mode
# ask nicely for the dark mode if available
# c.colors.webpage.preferred_color_scheme = "dark"
# not-like it: c.colors.webpage.darkmode.algorithm = 'brightness-rgb'
# c.colors.webpage.darkmode.algorithm = 'lightness-cielab'  #  fine
# c.colors.webpage.darkmode.algorithm = 'lightness-hsl' #  maybe I like this one better
# c.colors.webpage.darkmode.enabled = True

# Dracula theme init
dracula.draw.blood(c, {"spacing": {"vertical": 6, "horizontal": 8}})

# Bindings
config.bind(",j", "config-cycle content.javascript.enabled False True")
config.bind(",d", "config-cycle colors.webpage.darkmode.enabled False True")
config.bind(",rr", "restart")
