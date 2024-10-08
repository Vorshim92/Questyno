require("SFQuest_PlayerHandler")

--local base_SF_PlayerHandler_StartPlayer = SF_PlayerHandler.StartPlayer;
local original_fun
function SFQuest_PlayerHandler.StartPlayerFix()
    --if false then
       -- base_SF_PlayerHandler_StartPlayer(int, player);
   --end
	local player = getPlayer();

	-- -- If there is a backup file for the player's account then we use that, if not start it from zero.
	-- if isClient() then
	-- 	print("zSOUL QUEST SYSTEM - Requesting backup quest data [pre init].");
	-- 	local id = player:getUsername();
	-- 	sendClientCommand(player, 'SFQuest', 'sendData', {id = id});
	-- end
	-- local progress = player:getModData().missionProgress;
	if not player:getModData().missionProgress then
		print("zSOUL QUEST SYSTEM - Starting player from zero.");
		player:getModData().missionProgress = SFQuest_PlayerHandler.startingPlayerStats;

		--inserting factions from Database here
		for k,v in pairs(SFQuest_Database.FactionPool) do
			local factionTable = {};
			factionTable.factioncode = v.factioncode;
			factionTable.name = v.name;
			factionTable.reputation = v.startrep;
			factionTable.repmax = v.tiers[1].minrep;
			factionTable.tierlevel = 1;
			factionTable.tiername = v.tiers[1].tiername;
			factionTable.tiercolor = v.tiers[1].barcolor;
			table.insert(player:getModData().missionProgress.Factions, factionTable);
		end

		for q,u in pairs(SFQuest_Database.StartingPool) do
			local hasCondition = true;
			if u.condition then
				local condition = luautils.split(u.condition, ";");
				if condition[1] == "profession" and player:getDescriptor() and player:getDescriptor():getProfession() ~= condition[2] then
					hasCondition = false;
				elseif condition[1] == "trait" and not player:HasTrait(condition[2]) then
					hasCondition = false;
				end
			end
			if hasCondition == true then
				if u.click then
					local commandTable = luautils.split(u.click, ";");
					SF_MissionPanel.instance:runCommand("clickevent",  commandTable[1], commandTable[2], commandTable[3]);
				end
				if u.daily then
					local daily = SF_MissionPanel.instance:getDailyEvent(u.daily);
					SF_MissionPanel.instance:runCommand("unlockdaily", daily);	
				end
				if u.quest then
					SF_MissionPanel.instance:unlockQuest(u.quest);
				end
				if u.timer then
					SF_MissionPanel.instance:runCommand("unlocktimer", u.timer);
				end
				if u.randomworldfrompool then
					local entry = luautils.split(u.randomworldfrompool, ";");
					SF_MissionPanel.instance:runCommand("randomcodedworldfrompool", entry[1], entry[2], entry[3]);				
				end
				if u.world then
					local entry = luautils.split(u.world, ";");
					SF_MissionPanel.instance:runCommand("unlockworldevent", entry[1], entry[2], entry[3]);
				end
			end
		end

		-- SF_MissionPanel.instance:triggerUpdate();		
		if isClient() then
			print("zSOUL QUEST SYSTEM - Requesting backup quest data.");
			local id = player:getUsername();
			sendClientCommand(player, 'SFQuest', 'sendData', {id = id});
		else
			print("zSOUL QUEST SYSTEM - Loading backup quest data server side FROM PlayerHandler.");
			local id = player:getUsername();	
			local filepath = "/Backup/SFQuest_" .. id .. ".txt";
			local filereader = getFileReader(filepath, false);
			if not filereader then return nil end;
			local temp = {}
			local line = filereader:readLine();
			while line ~= nil do
				assert(loadstring(line));
				line = filereader:readLine();
			end
			filereader:close();		
			player:getModData().missionProgress = temp;
			SF_MissionPanel.instance:triggerUpdate();
		end
	else
		print("zSOUL QUEST SYSTEM - missionProgress already exists. Just check if there is data difference between server and client.")
		if isClient() then
			print("zSOUL QUEST SYSTEM - Requesting backup quest data.");
			local id = player:getUsername();
			sendClientCommand(player, 'SFQuest', 'sendData', {id = id});
		end
	end
end

local function OnPlayerDeath(player)
	if not player:getModData().missionProgress then print("[OnPlayerDeath][DEBUG-KILLZOMBIES] - Player has no missionProgress data."); return end;
	local needUpdate = false;
	for k,v in pairs(player:getModData().missionProgress.ActionEvent) do
		local condition = luautils.split(v.condition, ";");
		if condition[1] == "killzombies" then
			local newcount = 0
			if tonumber(condition[2]) > player:getZombieKills() then
				newcount = tonumber(condition[2]) - player:getZombieKills();
			end
			player:getModData().missionProgress.ActionEvent[k].condition = condition[1] .. ";" .. newcount;
			needUpdate = true;
			print("[OnPlayerDeath][DEBUG-KILLZOMBIES] - Updated killzombies condition from " .. condition[2] .. " to " .. newcount);
		end
	end
	if needUpdate == true then
		SF_MissionPanel.instance:backupData();
		print("[OnPlayerDeath][DEBUG-KILLZOMBIES] - Backup data updated.");
	else
		print("[OnPlayerDeath][DEBUG-KILLZOMBIES] - No need to update backup data.");
	end
end


local tickDelay = 20
function CreateDelay()
    if tickDelay <= 0 then
		print("Delay over, executing functions.")
		 -- Call your custom functions after delay
		 SFQuest_PlayerHandler.StartPlayerFix()
		 -- Remove this function from the OnTick event to stop it from running
		 Events.OnTick.Remove(CreateDelay)
    	return
    end
    tickDelay = tickDelay - 1
end

local function onCreatedPlayer(playerIndex, player)
    Events.OnTick.Add(CreateDelay)
end

Events.OnGameBoot.Add(function()
	Events.OnCreatePlayer.Remove(SFQuest_PlayerHandler.StartPlayer);
    Events.OnCreatePlayer.Add(onCreatedPlayer)
	Events.OnPlayerDeath.Add(OnPlayerDeath)

    original_fun = SFQuest_PlayerHandler.StartPlayer
    SFQuest_PlayerHandler.StartPlayer = SFQuest_PlayerHandler.StartPlayerFix
end)