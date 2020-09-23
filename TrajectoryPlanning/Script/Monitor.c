void Transmit_UCMD_FrogPKG()
{
	if (!g_bFrogMonitor)
		return;

	Phoenix* _pPhoenix =  PhoenixCommon_GetControlerMaster(&g_Phoenixs[0]);
	typedef	struct
	{
		u8 nCmd;
		u8 nLength;
		u8 nFollowOffTime[2];
		u8 nRecvFrog[2];
		u8 nStartFrog[2];
		u8 nRecvFrogTime[2];
		u8 nUpTime[2];
		u8 nHoldTime[2];
		u8 nInterTime[2];
		u8 nPID[2];
		u8 nRecvFollow[2];
		u8 nExitDryTime[2];
		u8 nFollowReady[2];
		u8 nCrc;
	}PKG;

	PKG _pkg;
	memset(&_pkg, 0, sizeof(_pkg));
	_pkg.nCmd = 0x55;
	_pkg.nLength = sizeof(_pkg);

	memcpy(_pkg.nFollowOffTime, &g_FrogMonitor.nFollowOffTime, 2);
	memcpy(_pkg.nRecvFrog, &g_FrogMonitor.nRecvFrogCmdTime, 2);
	memcpy(_pkg.nStartFrog, &g_FrogMonitor.nStartFrog, 2);
	memcpy(_pkg.nRecvFrogTime, &g_FrogMonitor.nRecvFrogTime, 2);
	memcpy(_pkg.nUpTime, &g_FrogMonitor.nUpTime, 2);
	memcpy(_pkg.nHoldTime, &g_FrogMonitor.nHoldTime, 2);
	memcpy(_pkg.nInterTime, &g_FrogMonitor.nInterTime, 2);
	memcpy(_pkg.nPID, &g_FrogMonitor.nPID, 2);
	memcpy(_pkg.nRecvFollow, &g_FrogMonitor.nRecvFollow, 2);
	memcpy(_pkg.nFollowReady, &g_FrogMonitor.nFollowReady, 2);
	memcpy(_pkg.nExitDryTime, &g_FrogMonitor.nExitDryTime, 2);

	if (PhoenixCommon_Transmit(_pPhoenix, _pPhoenix->pSelfUart, (u8*)&_pkg))
	{
	//	g_Monitor.bSend = FALSE;
	}
}
