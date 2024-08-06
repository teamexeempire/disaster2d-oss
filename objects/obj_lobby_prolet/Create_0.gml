mapData = 
[
	{ tiles: [ spr_pr_hst, spr_pr_hst2, spr_pr_hst3 ], bg: spr_pr_hstbg, side: [ true, false, false ] },
	{ tiles: [ spr_pr_rm, spr_pr_rm2 ], bg: spr_pr_rmbg, side: [ false, false ] },
	{ tiles: [ spr_pr_dot, spr_pr_dot2, spr_pr_dot3 ], bg: background_dotdotdot, side: [ false, false, false ] },
	{ tiles: [ spr_pr_dt, spr_pr_dt2, spr_pr_dt3 ], bg: spr_pr_dtbg, side: [ false, true, false ] },
	{ tiles: [ spr_pr_ycr, spr_pr_ycr2, spr_pr_ycr3 ], bg: spr_pr_ycrbg, side: [ false, false, true ] },
	{ tiles: [ spr_pr_lc, spr_pr_lc2, spr_pr_lc3 ], bg: spr_pr_lcbg, side: [ false, false, false ] },
	{ tiles: [ spr_pr_np, spr_pr_np2, spr_pr_np3, spr_pr_np4 ], bg: spr_pr_npbg, side: [ false, true, false, true ] },
	{ tiles: [ spr_pr_kaf, spr_pr_kaf2, spr_pr_kaf3 ], bg: spr_pr_kafbg, side: [ false, false, false ] },
	{ tiles: [ spr_pr_act9, spr_pr_act92, spr_pr_act93 ], bg: background_act9, side: [ false, true, false ] },
	{ tiles: [ spr_pr_nap, spr_pr_nap2, spr_pr_nap3 ], bg: spr_pr_napbg, side: [ false, false, false ] },
	{ tiles: [ spr_pr_pf, spr_pr_pf2, spr_pr_pf3 ], bg: background_pf, side: [ false, false, false ] },
	{ tiles: [ spr_pr_vv, spr_pr_vv2, spr_pr_vv3 ], bg: spr_pr_vvbg, side: [ false, false, false ] },
	{ tiles: [ spr_pr_ghz, spr_pr_ghz2, spr_pr_ghz3 ], bg: spr_pr_ghzbg, side: [ false, false, false ] },
	{ tiles: [ spr_pr_mf, spr_pr_mf2, spr_pr_mf3 ], bg: spr_pr_mfbg, side: [ false, false, false ] },
	{ tiles: [ spr_pr_hs, spr_pr_hs2, spr_pr_hs3 ], bg: spr_pr_hsbg, side: [ false, false, false ] },
	{ tiles: [ spr_pr_tc, spr_pr_tc2, spr_pr_tc3 ], bg: spr_pr_tcbg, side: [ false, false, false ] },
	{ tiles: [ spr_pr_dark, spr_pr_dark2, spr_pr_dark3 ], bg: background_darktower, side: [ false, false, false ] },
	{ tiles: [ spr_pr_hd, spr_pr_hd2, spr_pr_hd3 ], bg: spr_pr_hdbg, side: [ false, false, false ] },
	{ tiles: [ spr_pr_wd, spr_pr_wd2, spr_pr_wd3 ], bg: spr_pr_wdbg, side: [ false, false, true ] },
	{ tiles: [ spr_pr_ma, spr_pr_ma2, spr_pr_ma3 ], bg: spr_pr_mabg, side: [ false, false, false ] },
	
	{ tiles: [ spr_pr_hd, spr_pr_hd2, spr_pr_hd3 ], bg: background_test, side: [ false, false, false ] },
	
];

setZone = function(_map)
{
	index = irandom_range(0, array_length(mapData[_map].tiles)-1);
	scroll = 0;
	map = _map;
	side = mapData[_map].side[index];
}

index = 0;
scroll = 0;
map = 6;
side = false;
blackwhite = false;