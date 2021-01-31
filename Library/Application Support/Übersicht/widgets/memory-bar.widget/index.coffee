command: "sysctl -n hw.memsize && vm_stat"

refreshFrequency: 5 * 1000

style: """
  // Change bar height
  bar-height = 6px

  // Align contents left or right
  widget-align = left

  // Position this where you want
  bottom 10px
  left 10px

  // Statistics text settings
  color #fff
  font-family Helvetica Neue
  background rgba(#000, .5)
  padding 10px 10px 15px
  border-radius 5px

  .container
    width: 600px
    text-align: widget-align
    position: relative
    clear: both

  .widget-title
    text-align: widget-align

  .stats-container
    margin-bottom 5px
    border-collapse collapse

  td
    font-size: 14px
    font-weight: 300
    color: rgba(#fff, .9)
    text-shadow: 0 1px 0px rgba(#000, .7)
    text-align: widget-align

  .widget-title
    font-size 10px
    text-transform uppercase
    font-weight bold

  .label
    font-size 8px
    text-transform uppercase
    font-weight bold

  .bar-container
    width: 100%
    height: bar-height
    border-radius: bar-height
    float: widget-align
    clear: both
    background: rgba(#fff, .5)
    margin-top: 5px

  .bar
    height: bar-height
    float: widget-align
    transition: width .2s ease-in-out

  .bar:first-child
    if widget-align == left
      border-radius: bar-height 0 0 bar-height
    else
      border-radius: 0 bar-height bar-height 0

  .bar:last-child
    if widget-align == right
      border-radius: bar-height 0 0 bar-height
    else
      border-radius: 0 bar-height bar-height 0

  .bar-inactive
    background: rgba(#0bf, .5)

  .label-inactive
    color: rgba(#0bf, .7)

  .bar-app
    background: rgba(#0fb, .5)

  .label-app
    color: rgba(#0fb, .7)

  .bar-active
    background: rgba(#fc0, .5)

  .label-active
    color: rgba(#fc0, .7)

  .bar-compressed
    background: rgba(#30f, .5)

  .label-compressed
    color: rgba(#a7f, .7)

  .bar-wired
    background: rgba(#c00, .5)

  .label-wired
    color: rgba(#c00, .7)

  .bar-cached
    background: rgba(#333, .5)

  .label-cached
    color: rgba(#888, .7)

  .label-free
    color: rgba(#fff, .5)
"""


render: -> """
  <div class="container">
    <div class="widget-title">Memory</div>
    <table class="stats-container" width="100%">
      <tr>
        <td class="stat"><span class="wired"></span></td>
        <td class="stat"><span class="active"></span></td>
        <td class="stat"><span class="inactive"></span></td>
        <td class="stat"><span class="app"></span></td>
        <td class="stat"><span class="compressed"></span></td>
        <td class="stat"><span class="cached"></span></td>
        <td class="stat"><span class="free"></span></td>
        <td class="stat"><span class="total"></span></td>
      </tr>
      <tr>
        <td class="label label-wired">wired</td>
        <td class="label label-active">active</td>
        <td class="label label-inactive">inactive</td>
        <td class="label label-app">app</td>
        <td class="label label-compressed">compressed</td>
        <td class="label label-cached">cached</td>
        <td class="label label-free">free</td>
        <td class="label">total</td>
      </tr>
    </table>
    <div class="bar-container">
      <div class="bar bar-wired"></div>
      <div class="bar bar-active"></div>
      <div class="bar bar-inactive"></div>
    </div>
    <div class="bar-container">
      <div class="bar bar-wired"></div>
      <div class="bar bar-app"></div>
      <div class="bar bar-compressed"></div>
      <div class="bar bar-cached"></div>
    </div>
  </div>
"""

update: (output, domEl) ->
  usage = (pages, pageSize) ->
    mb = (pages * pageSize) / 1024 / 1024
    usageFormat mb

  usageFormat = (mb) ->
    if mb > 1024
      gb = mb / 1024
      "#{parseFloat(gb.toFixed(2))}GB"
    else
      "#{parseFloat(mb.toFixed())}MB"

  updateStat = (sel, usedPages, pageSize, totalBytes) ->
    usedBytes = usedPages * pageSize
    percent = (usedBytes / totalBytes * 100).toFixed(1) + "%"
    $(domEl).find(".#{sel}").text usage(usedPages, pageSize)
    $(domEl).find(".bar-#{sel}").css "width", percent

  lines = output.split "\n"

  # ps = 16384
  ps = lines[1].split(" ")[7]
  freePages = lines[2].split(": ")[1]
  activePages = lines[3].split(": ")[1]
  inactivePages = lines[4].split(": ")[1]
  speculativePages = lines[5].split(": ")[1]
  wiredPages = lines[7].split(": ")[1]
  purgeablePages = lines[8].split(": ")[1]
  fileBackedPages = lines[14].split(": ")[1]
  anonymousPages = lines[15].split(": ")[1]
  compressedPages = lines[17].split(": ")[1]
  appPages = anonymousPages - purgeablePages
  # cachedPages = fileBackedPages
  cachedPages = fileBackedPages + speculativePages

  totalBytes = lines[0]
  $(domEl).find(".total").text usageFormat(totalBytes / 1024 / 1024)

  updateStat 'wired', wiredPages, ps, totalBytes
  updateStat 'free', freePages, ps, totalBytes
  updateStat 'active', activePages, ps, totalBytes
  updateStat 'inactive', inactivePages, ps, totalBytes
  updateStat 'compressed', compressedPages, ps, totalBytes
  updateStat 'cached', fileBackedPages, ps, totalBytes
  updateStat 'app', appPages, ps, totalBytes
