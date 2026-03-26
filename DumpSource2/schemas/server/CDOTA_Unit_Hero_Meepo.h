class CDOTA_Unit_Hero_Meepo : public CDOTA_BaseNPC_Hero
{
	bool m_bRecursionGuard;
	CHandle< CBaseEntity > m_hItemToDuplicate;
	int32 m_nWhichMeepo;
};
