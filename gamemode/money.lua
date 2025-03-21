/*
function setMoney(player, amount)
	local IDSteam = string.gsub(player:SteamID(), ":", "")

	local contents = file.Read("DarkRP/" .. IDSteam .. ".txt")
	local newAmount = math.ceil(contents + amount)

	file.Write( "DarkRP/" .. IDSteam .. ".txt", newAmount )
end

function getMoney(player)
	local IDSteam = string.gsub(player:SteamID(), ":", "")

	if not file.Exists("DarkRP/" .. IDSteam .. ".txt") then   
		file.Write( "DarkRP/" .. IDSteam .. ".txt","5000" )
	end
	
	local contents = file.Read("DarkRP/" .. IDSteam .. ".txt")

	
	local plmoney = math.ceil(tonumber(contents))
	player:GetTable().Money = plmoney
	// if its more than a long, just basically say A LOT
	if (player:GetTable().Money>2147483647) then
		plmoney = 2147483647
	end
	umsg.Start("MoneyChange", player)
		umsg.Short(0)
		umsg.Long(plmoney)
	umsg.End()
end
*/

// DB
require( "mysql" )
db = nil
error = nil
function DBConnect()
	local moneytable = nil
	Msg("Connecting to database...\n")
	// 192.168.1.100
	db, error = mysql.connect("Localhost", "root", "", "wcarpdm");
	if (db == 0) then Msg(error .. "\n") else Msg("Connection Successful.\n") moneytable = db end
	
	/*
	local succ,error = tmysql.disconnect(db)
	if !succ then Msg(error.."\n") end
	*/
end
function setMoney(player, amount)
	local IDSteam = string.lower(string.gsub(player:SteamID(), ":", ""))
	//player:GetTable().Money = player:GetTable().Money+amount
	if tonumber(player:GetTable().Money)!=nil then
		local tbl,udt,err = mysql.query(db, "UPDATE rpdmmoney SET Money="..tostring(player:GetTable().Money).." WHERE SteamID='"..IDSteam.."'")
		if !udt then Msg(error.."\n") end
	end
end

function getMoney(player)
	
	local IDSteam = string.lower(string.gsub(player:SteamID(), ":", ""))
	
	
	local table,succ,error = mysql.query(db, "SELECT Money FROM rpdmmoney WHERE SteamID='"..IDSteam.."'")
	if !succ then Msg(error.."\n") end
	local plmoney = 5000
	if table[1]!=nil && tonumber(table[1][1])!=nil then
		plmoney = math.ceil(tonumber(table[1][1]))
	else
		Msg("Adding new user: " ..IDSteam.."\n")
		local tbl,udt,err = mysql.query(db, "INSERT INTO rpdmmoney (SteamID, Money) values ('"..IDSteam.."', 5000)")
		if !udt then Msg(error.."\n") end
	end
	player:GetTable().Money = plmoney
	// if its more than a long, just basically say A LOT
	if (player:GetTable().Money>2147483647) then
		plmoney = 2147483647
	end
	umsg.Start("MoneyChange", player)
		umsg.Short(0)
		umsg.Long(plmoney)
	umsg.End()
end