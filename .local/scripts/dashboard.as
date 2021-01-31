tell app "System Events"
    set response to display dialog "Add Dashboard URL:" default answer "http://" with icon note buttons {"Cancel", "Open"} default button "Open"
end tell
text returned of response
