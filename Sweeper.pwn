#include <a_samp>
#include <streamer>

#define COLOR_DARKGOLD 			0x808000AA
#define COLOR_RED				0xAA3333AA
#define COLOR_YELLOW 			0xFFFF00AA
#define COLOR_ORANGE			0xFF9900AA
#define COLOR_GRAY				0xC0C0C0AA
#define COLOR_WHITE				0xFFFFFFAA

new SweepVeh[MAX_PLAYERS];
new Checkpoints[MAX_PLAYERS];
new Cooldown[MAX_PLAYERS];
new Pickup;

public OnFilterScriptInit()
{
	//Spawn kendaraan job
	//AddStaticVehicle(574,2191.1924,-1984.6196,13.3228,92.0006,25,1);
	//AddStaticVehicle(574,2192.0505,-1989.6973,13.3181,90.3178,25,1);
	//AddStaticVehicle(574,2191.4207,-1994.5468,13.3188,91.7292,25,1);
	Create3DTextLabel("Willowfield Sweeping Co.", COLOR_RED, 2193.5544,-1974.0602,13.5595, 10.0, 0, 0);
	Pickup = CreatePickup(1272, 0, 2193.5544,-1974.0602,13.5595, -1);
	CreateDynamicMapIcon(2193.5544,-1974.0602,13.5595, 56, -1, -1, -1, -1, 100);
    print("[FS]Street Sweeping Job has loaded successfully");
	return 1;
}

public OnFilterScriptExit()
{
	print("[FS]Street Sweeping Job has unloaded successfully");
	DestroyPickup(Pickup);
	Pickup = 0;
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
     if(GetPlayerVehicleID(playerid) == 574)
     {
         SendClientMessage(playerid, COLOR_RED, "* You can start the sweepingjob by using /sweep");
     }
     return 0;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 574)
    {
    	if(SweepVeh[playerid] != 0)
   		{
   			DestroyVehicle(SweepVeh[playerid]);
   			DisablePlayerCheckpoint(playerid);
			Checkpoints[playerid] = 0;
   			SendClientMessage(playerid, COLOR_WHITE, "The Sweeper job has ended as you have exited the vehicle.");
   		}
    }
    return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new string[128];
    if(strcmp("/sweep", cmdtext, true, 10) == 0)
    {
        if (IsPlayerInRangeOfPoint(playerid, 7.0, 2193.5544,-1974.0602,13.5595))
    	{
    	    if (gettime() < Cooldown[playerid])
    	    {
    	        format(string,sizeof(string),"You can do the job again in %i minutes",((Cooldown[playerid] - gettime())/60));
				SendClientMessage(playerid, COLOR_GRAY, string);
			}
			else
			{
      			Checkpoints[playerid] = 1;
    			SetPlayerCheckpoint(playerid, 2217.9097,-1937.8906,13.1039, 3.0);
    			SendClientMessage(playerid, COLOR_ORANGE, "Help clean the streets of Los Santos by sweeping the roads. (/stopsweep to abort the job)");
    			SweepVeh[playerid] = CreateVehicle(574,2199.5483,-1979.6445,13.3251, 268.9210, -1, -1, 1);
    			PutPlayerInVehicle(playerid, SweepVeh[playerid], 0);
				return 1;
			}
    	}
    	else
    	{
    	    SendClientMessage(playerid, COLOR_RED,"You must be at the sweeper station to start.");
    	}

    	return 1;
    }
    
    if(strcmp("/stopsweep", cmdtext, true, 10) == 0 && Checkpoints[playerid] >= 1)
    {
        DisablePlayerCheckpoint(playerid);
        Checkpoints[playerid] = 0;
        DestroyVehicle(SweepVeh[playerid]);
		SendClientMessage(playerid, COLOR_DARKGOLD, "You cancel the sweeper job.");
		return 1;
    }
    return 0;
}

public OnPlayerEnterCheckpoint(playerid)
{
    if(Checkpoints[playerid] == 1)
    {
        DisablePlayerCheckpoint(playerid);
        Checkpoints[playerid] = 2;
        SetPlayerCheckpoint(playerid, 2175.9075,-1892.1901,13.1224, 3.0);
        PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
        return 1;
    }
    
    if(Checkpoints[playerid] == 2)
    {
        DisablePlayerCheckpoint(playerid);
        Checkpoints[playerid] = 3;
        SetPlayerCheckpoint(playerid, 2071.7974,-1930.2050,13.1376, 3.0);
        PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
        return 1;
    }
    
    if(Checkpoints[playerid] == 3)
    {
        DisablePlayerCheckpoint(playerid);
        Checkpoints[playerid] = 4;
        SetPlayerCheckpoint(playerid, 1959.2094,-1944.6680,13.2543, 3.0);
        PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
        return 1;
    }
    
    if(Checkpoints[playerid] == 4)
    {
        DisablePlayerCheckpoint(playerid);
        Checkpoints[playerid] = 5;
        SetPlayerCheckpoint(playerid, 1977.6603,-2112.2292,13.1343, 3.0);
        PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
        return 1;
    }
    
    if(Checkpoints[playerid] == 5)
    {
        DisablePlayerCheckpoint(playerid);
        Checkpoints[playerid] = 6;
        SetPlayerCheckpoint(playerid, 2180.6563,-2150.3298,13.1519, 3.0);
        PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
        return 1;
    }
    
    if(Checkpoints[playerid] == 6)
    {
        DisablePlayerCheckpoint(playerid);
        Checkpoints[playerid] = 7;
        SetPlayerCheckpoint(playerid, 2253.7312,-2113.7327,13.2689, 3.0);
        PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
        return 1;
    }
    
    if(Checkpoints[playerid] == 7)
    {
        DisablePlayerCheckpoint(playerid);
        Checkpoints[playerid] = 8;
        SetPlayerCheckpoint(playerid, 2271.7144,-2065.5674,13.1534, 3.0);
        PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
        return 1;
    }
    
    if(Checkpoints[playerid] == 8)
    {
        DisablePlayerCheckpoint(playerid);
        Checkpoints[playerid] = 9;
        SetPlayerCheckpoint(playerid, 2219.7336,-2010.3698,13.1296, 3.0);
        PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
        return 1;
    }
    
    if(Checkpoints[playerid] == 9)
    {
        DisablePlayerCheckpoint(playerid);
        Checkpoints[playerid] = 10;
        SetPlayerCheckpoint(playerid, 2175.4907,-1978.3552,13.3239, 3.0);
        PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
        return 1;
    }
    
    if(Checkpoints[playerid] == 10) //CP Terakhir
    {
        new string[128];
        PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
        DisablePlayerCheckpoint(playerid);
        Checkpoints[playerid] = 0;
        DestroyVehicle(SweepVeh[playerid]);
        GivePlayerMoney(playerid, 300);
        format(string, sizeof(string), "You have received $300 for your work. You can sweep again in 60 minutes.");
        SendClientMessage(playerid, COLOR_ORANGE, string);
        Cooldown[playerid] = gettime() + (60*60);
    }
    return 1;
}
