/client
	var/country = null

/client/New()
	. = ..()
	spawn if(src)
		src.country = ip2country(address)

/proc/ip2country(ipaddr)
	var/list/http_response[] = world.Export("http://ip-api.com/json/[ipaddr]")
	var/page_content = http_response["CONTENT"]
	if(page_content)
		var/list/geodata = json_decode(html_decode(file2text(page_content)))
		return geodata["countryCode"]

var/list/countries = icon_states('icons/flags.dmi') //BLYAAAAAAAAAAAAAAT

/proc/country2chaticon(country_code)
	if(countries.Find(country_code))
		return "[icon2html('icons/flags.dmi', world, country_code)]"
	else
		return "[icon2html('icons/flags.dmi', world, "unknown")]"