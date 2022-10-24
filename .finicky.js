// Use https://finicky-kickstart.now.sh to generate basic configuration
// Learn more about configuration options: https://github.com/johnste/finicky/wiki/Configuration

module.exports = {
  defaultBrowser: "Qutebrowser",
  handlers: [
    {
      match: [
        "calendar.google.com*",
        "meet.google.com*",
        "do.co/bbzd",
        "do.co/coffee",
        "digitalocean.slack.com*",
        "grafana.internal.digitalocean.com*",
        "grafana.s2r1.internal.digitalocean.com*"
      ],
      browser: "Google Chrome"
    },
    {
      match: [
        "youtube.com*"
      ],
      browser: "Safari"
    }
  ]
}
