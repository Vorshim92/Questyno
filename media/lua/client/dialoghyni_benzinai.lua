require 'SFQuest_Database'

--[[
            *** BENZINAI ***
            - JuanBaker 3837,7028,1 W
            - Benjamin Scott 6688,7467,1 E
            - Sandra Harris 6684,6820,1 S
            - Eric Adams 7659,7316,1 E
            - Ronald Perez 8353,8579,1 E
            - Garrett King 10399,8316,1 E
            - Marvin Perry 8186,11296,1 E
            - Karen Taylor 10144,12787,1 S
]]

table.insert(SFQuest_Database.DialoguePool, {dialoguecode = "SFQuest_Questyno_JuanBaker_Begin", context = "ContextMenu_WorldEvent_TalkTo",command = "unlockquest;Questyno_JuanBaker", optional = true, text = "IGUI_SFQuest_Questyno_JuanBaker_Begin", textaccepted = "IGUI_SFQuest_Questyno_JuanBaker_Accepted",textdeclined = "IGUI_SFQuest_Questyno_JuanBaker_Declined"})
table.insert(SFQuest_Database.DialoguePool, {dialoguecode = "SFQuest_Questyno_BenjaminScott_Begin", context = "ContextMenu_WorldEvent_TalkTo",command = "unlockquest;Questyno_BenjaminScott", optional = true, text = "IGUI_SFQuest_Questyno_BenjaminScott_Begin", textaccepted = "IGUI_SFQuest_Questyno_BenjaminScott_Accepted",textdeclined = "IGUI_SFQuest_Questyno_BenjaminScott_Declined"})
table.insert(SFQuest_Database.DialoguePool, {dialoguecode = "SFQuest_Questyno_SandraHarris_Begin", context = "ContextMenu_WorldEvent_TalkTo",command = "unlockquest;Questyno_SandraHarris", optional = true, text = "IGUI_SFQuest_Questyno_SandraHarris_Begin", textaccepted = "IGUI_SFQuest_Questyno_SandraHarris_Accepted",textdeclined = "IGUI_SFQuest_Questyno_SandraHarris_Declined"})
table.insert(SFQuest_Database.DialoguePool, {dialoguecode = "SFQuest_Questyno_EricAdams_Begin", context = "ContextMenu_WorldEvent_TalkTo",command = "unlockquest;Questyno_EricAdams", optional = true, text = "IGUI_SFQuest_Questyno_EricAdams_Begin", textaccepted = "IGUI_SFQuest_Questyno_EricAdams_Accepted",textdeclined = "IGUI_SFQuest_Questyno_EricAdams_Declined"})
table.insert(SFQuest_Database.DialoguePool, {dialoguecode = "SFQuest_Questyno_RonaldPerez_Begin", context = "ContextMenu_WorldEvent_TalkTo",command = "unlockquest;Questyno_RonaldPerez", optional = true, text = "IGUI_SFQuest_Questyno_RonaldPerez_Begin", textaccepted = "IGUI_SFQuest_Questyno_RonaldPerez_Accepted",textdeclined = "IGUI_SFQuest_Questyno_RonaldPerez_Declined"})
table.insert(SFQuest_Database.DialoguePool, {dialoguecode = "SFQuest_Questyno_GarrettKing_Begin", context = "ContextMenu_WorldEvent_TalkTo",command = "unlockquest;Questyno_GarrettKing", optional = true, text = "IGUI_SFQuest_Questyno_GarrettKing_Begin", textaccepted = "IGUI_SFQuest_Questyno_GarrettKing_Accepted",textdeclined = "IGUI_SFQuest_Questyno_GarrettKing_Declined"})
table.insert(SFQuest_Database.DialoguePool, {dialoguecode = "SFQuest_Questyno_MarvinPerry_Begin", context = "ContextMenu_WorldEvent_TalkTo",command = "unlockquest;Questyno_MarvinPerry", optional = true, text = "IGUI_SFQuest_Questyno_MarvinPerry_Begin", textaccepted = "IGUI_SFQuest_Questyno_MarvinPerry_Accepted",textdeclined = "IGUI_SFQuest_Questyno_MarvinPerry_Declined"})
table.insert(SFQuest_Database.DialoguePool, {dialoguecode = "SFQuest_Questyno_KarenTaylor_Begin", context = "ContextMenu_WorldEvent_TalkTo",command = "unlockquest;Questyno_KarenTaylor", optional = true, text = "IGUI_SFQuest_Questyno_KarenTaylor_Begin", textaccepted = "IGUI_SFQuest_Questyno_KarenTaylor_Accepted",textdeclined = "IGUI_SFQuest_Questyno_KarenTaylor_Declined"})