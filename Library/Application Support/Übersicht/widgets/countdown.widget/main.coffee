MILLIS_IN_DAY: 24 * 60 * 60 * 1000
MILLIS_IN_HOUR: 60 * 60 * 1000
MILLIS_IN_MINUTE: 60 * 1000
MILLIS_IN_SECOND: 1000

countdowns: [
    {
        label: "Valentine's Day",
        time: "February 14, 2023 12:00 AM"
    }, {
        label: "Tax Day",
        time: "April 15, 2023 12:00 AM"
    }, {
        label: "Nicole's Day",
        time: "July 18, 2023 12:00 AM"
    }, {
        label: "Anniversary",
        time: "Aug 28, 2023 12:00 AM"
    }, {
        label: "Christmas",
        time: "Dec 25, 2023 12:00 AM"
    }, {
        label: "My Day",
        time: "Jan 13, 2024 12:00 AM"
    }
]

command: ""

refreshFrequency: 30 * 1000

style: """
	top 80px
	left 0px

	*
		margin 10px

	#container
		margin 10px 10px 15px
		padding 10px
		border-radius 5px

		color rgba(#fff, .9)
		font-family Helvetica Neue
	
	span
		font-size 14pt
		font-weight bold

	ul
		list-style none

	li
		padding 10px

		&:not(:last-child)
			border-bottom solid 1px white

	thead
		font-size 8pt
		font-weight bold

		td
			width 60px

	tbody
		font-size 12pt

	td
		text-align center
"""

render: -> """
	<div id="container">
		<ul>
		</ul>
	</div>
"""

afterRender: ->
	for countdown in @countdowns
		countdown.millis = new Date(countdown.time).getTime()

update: (output, domEl) ->
	$countdownList = $(domEl).find("#container").find("ul")
	$countdownList.empty()

	now = new Date().getTime()

	# $root.html new Date
	# $root.html new Date @countdowns[1].time
	for countdown in @countdowns
		millisUntil = countdown.millis - now

		timeUntil = {
			days: 0,
			hours: 0,
			minutes: 0,
			seconds: 0
		}

		if millisUntil > 0
			timeUntil.days = millisUntil // @MILLIS_IN_DAY
			millisUntil %= @MILLIS_IN_DAY

			timeUntil.hours = millisUntil // @MILLIS_IN_HOUR
			millisUntil %= @MILLIS_IN_HOUR

			timeUntil.minutes = millisUntil // @MILLIS_IN_MINUTE
			millisUntil %= @MILLIS_IN_MINUTE

			timeUntil.seconds = millisUntil // @MILLIS_IN_SECOND
			millisUntil %= @MILLIS_IN_SECOND

		$countdownList.append("""
			<li>
				<span>#{countdown.label}</span>
				<table>
					<thead>
						<tr>
							<td>DAYS</td>
							<td>HOURS</td>
							<td>MINUTES</td>
						</tr>
					</thead>

					<tbody>
						<tr>
							<td>#{timeUntil.days}</td>
							<td>#{timeUntil.hours}</td>
							<td>#{timeUntil.minutes}</td>
						</tr>
					</tbody>
				</table>
			</li>
		""")
