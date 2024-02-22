set input to {"blah"}

set searchString to input as text

set AppleScript's text item delimiters to space
set searchString to text items of searchString
set AppleScript's text item delimiters to ""
set searchString to searchString as text

tell application "Google Chrome"
	tell front window
		set curTabIndex to active tab index
		set URL of active tab to "https://www.dmv.ca.gov/wasapp/ica/VRProcessVehicle.do"
		repeat until (loading of active tab is false)
			delay 1
		end repeat
		-- choose what to update your address on
		tell active tab to execute javascript "document.getElementById('cb2').checked = true;"
		tell active tab to execute javascript "document.getElementsByClassName('pr-60 pl-60 mb-24 bp-md:mb-0')[0].click();"
		delay 1
		repeat until (loading of active tab is false)
			delay 1
		end repeat
		-- choose where to update your vehicle's address
		delay 1
		tell active tab to execute javascript "document.getElementById('residence-checkbox').checked = true;"
		tell active tab to execute javascript "document.getElementById('mailing-checkbox').checked = true;"
		tell active tab to execute javascript "document.getElementById('resChange').value = 'yes';"
		tell active tab to execute javascript "document.getElementById('mailChange').value = 'yes';"
		tell active tab to execute javascript "document.getElementsByClassName('pr-60 pl-60 mb-24 bp-md:mb-0')[0].click();"
		delay 1
		repeat until (loading of active tab is false)
			delay 1
		end repeat
		-- Enter Your New Residence Address.
		delay 0.5
		tell active tab to execute javascript "document.getElementById('street1').value = 'YOUR RESIDENCE ADDRESS STREET';"
		tell active tab to execute javascript "document.getElementById('resCity').value = 'YOUR RESIDENCE ADDRESS CITY';"
		tell active tab to execute javascript "document.getElementById('resState').value = 'YOUR RESIDENCE ADDRESS STATE (E.G. CA)';"
		tell active tab to execute javascript "document.getElementById('resZip').value = 'YOUR RESIDENCE ADDRESS ZIP';"
		tell active tab to execute javascript "document.getElementById('resCounty').value = 'YOUR RESIDENCE ADDRESS COUNTY (E.G. 21 = MARIN)';"
		tell active tab to execute javascript "document.getElementsByClassName('pr-60 pl-60 mb-24 bp-md:mb-0')[0].click();"
		delay 1
		repeat until (loading of active tab is false)
			delay 1
		end repeat
		-- Enter Your New Mailing Address
		tell active tab to execute javascript "document.getElementById('street1').value = 'YOUR MAILING ADDRESS STREET';"
		tell active tab to execute javascript "document.getElementById('mailCity').value = 'YOUR MAILING ADDRESS CITY';"
		tell active tab to execute javascript "document.getElementById('mailState').value = 'YOUR MAILING ADDRESS STATE (E.G. CA)';"
		tell active tab to execute javascript "document.getElementById('mailZip').value = 'YOUR MAILING ADDRESS ZIP';"
		tell active tab to execute javascript "document.getElementById('mailCounty').value = 'YOUR MAILING ADDRESS COUNTY (E.G. 21 = MARIN)';"
		tell active tab to execute javascript "document.getElementsByClassName('pr-60 pl-60 mb-24 bp-md:mb-0')[0].click();"
		delay 1
		repeat until (loading of active tab is false)
			delay 1
		end repeat
		-- Enter Vehicle Information
		tell active tab to execute javascript "document.getElementById('lastName1').value = 'YOUR LAST NAME';"
		tell active tab to execute javascript "document.getElementById('plate1').value = 'YOUR LICENSE PLATE';"
		tell active tab to execute javascript "document.getElementById('vin1').value = 'YOUR FULL VIN';"
		tell active tab to execute javascript "document.getElementById('leased1No').checked = true;"
		set monthlist to {"01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"}
		set daylist to {"01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"}
		set curmonthindex to 1
		set curdayindex to 1
		set noerror to false
		repeat until noerror
			set curmonth to item curmonthindex of monthlist
			set curday to item curdayindex of daylist
			tell active tab to execute javascript ("document.getElementById('month1').value = '" & curmonth & "';")
			tell active tab to execute javascript ("document.getElementById('regIssueDay1').value = '" & curday & "';")
			tell active tab to execute javascript "document.getElementById('regIssueYear1').value = '2020';"
			tell active tab to execute javascript "document.getElementsByClassName('pr-60 pl-60 mb-24 bp-md:mb-0')[0].click();"
			delay 1
			repeat until (loading of active tab is false)
				delay 1
			end repeat
			tell active tab
				set page_text to execute javascript "document.body.innerText"
			end tell
			if page_text contains "The vehicle information entered does not match DMV records. Please verify the information and try again." or page_text contains "is not a valid date" then
				set noerror to false
			else
				set noerror to true
				set notification_text to "Found your registration date! It is day " & curday & " of month " & curmonth
				display notification notification_text
			end if
			if curdayindex < 31 then
				set curdayindex to curdayindex + 1
			else
				set curdayindex to 1
				set curmonthindex to curmonthindex + 1
			end if
		end repeat
		
		delay 0.5
		set active tab index to curTabIndex
	end tell
end tell
