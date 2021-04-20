// Use https://finicky-kickstart.now.sh to generate basic configuration
// Learn more about configuration options: https://github.com/johnste/finicky/wiki/Configuration

module.exports = {
  defaultBrowser: "Qutebrowser",
  handlers: [
    {
      match: [
        "calendar.google.com*",
        "meet.google.com*",
        "do.co/bbzd"
      ],
      browser: "Google Chrome"
    }
  ]
}
