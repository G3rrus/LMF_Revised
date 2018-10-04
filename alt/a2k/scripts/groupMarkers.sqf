// GROUP MARKER SCRIPT ////////////////////////////////////////////////////////////////////////////

//Parameters:
//0. Group marker will be added to
//1. Color of marker
//2. Text added to marker
//3. Marker type

// Example: 0 = [Grp_A,"ColorEAST","A","b_inf"] spawn ax_fnc_group_markers;


if (hasInterface) then {

	ax_fnc_group_markers = {

		//Define marker and group
		_group = _this select 0;
		_color = if (count _this > 1) then {_this select 1} else {"ColorWEST"};
		_txt = if (count _this > 2) then {_this select 2} else {""};
		_type = if (count _this > 3) then {_this select 3} else {"b_unknown"};
		_size = if (count _this > 4) then {_this select 4} else {[1,1]};

		//Create marker
		_mrk = createMarkerLocal [format ["marker_%1",_group],getPos leader _group];
		_mrk setMarkerTypeLocal _type;
		_mrk setMarkerColorLocal _color;
		_mrk setMarkerTextLocal _txt;
		_mrk setmarkerSizeLocal _size;
		_mrk setMarkerAlphaLocal 0;

		if (count units _group > 0) then {_mrk setMarkerAlphaLocal 1;};

		//Update marker
		for "_i" from 0 to 1 step 0 do {
			if (count units _group > 0) then {
				_mrk setMarkerPosLocal (getPos leader _group);
				_mrk setMarkerAlphaLocal 1;
			} else
			{
				//_mrk setMarkerAlphaLocal 0;
			};
		sleep 1;
		};
	};


	//FOX PLATOON /////////////////////////////////////////////////////////////////////////////////
	if !(isNil "Grp_FOX_6") then {0 = [Grp_FOX_6,"ColorEAST","","LAMBS_FOX_6",[1,1]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_FOX_1") then {0 = [Grp_FOX_1,"ColorEAST","","LAMBS_FOX_1",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_FOX_2") then {0 = [Grp_FOX_2,"ColorEAST","","LAMBS_FOX_2",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_FOX_3") then {0 = [Grp_FOX_3,"ColorEAST","","LAMBS_FOX_3",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_FOX_4") then {0 = [Grp_FOX_4,"ColorEAST","","LAMBS_FOX_4",[0.8,0.8]] spawn ax_fnc_group_markers;};

	//WOLF PLATOON ////////////////////////////////////////////////////////////////////////////////
	if !(isNil "Grp_WOLF_6") then {0 = [Grp_WOLF_6,"ColorWEST","WOLF/6","b_support",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_WOLF_1") then {0 = [Grp_WOLF_1,"ColorWEST","DELTA","b_support",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_WOLF_2") then {0 = [Grp_WOLF_2,"ColorWEST","ECHO","b_recon",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_WOLF_3") then {0 = [Grp_WOLF_3,"ColorWEST","WOLF3","b_maint",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_WOLF_4") then {0 = [Grp_WOLF_4,"ColorWEST","WOLF4","b_support",[0.8,0.8]] spawn ax_fnc_group_markers;};

	//ARMOR ///////////////////////////////////////////////////////////////////////////////////////
	if !(isNil "Grp_DGR1") then {0 = [Grp_DGR1,"ColorWEST","DAGGER1","b_motor_inf",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_DGR2") then {0 = [Grp_DGR2,"ColorWEST","DAGGER2","b_motor_inf",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_DGR3") then {0 = [Grp_DGR3,"ColorWEST","DAGGER3","b_motor_inf",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_DGR4") then {0 = [Grp_DGR4,"ColorWEST","DAGGER4","b_motor_inf",[0.8,0.8]] spawn ax_fnc_group_markers;};

	if !(isNil "Grp_SWD1") then {0 = [Grp_SWD1,"ColorWEST","SWORD1","b_mech_inf",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_SWD2") then {0 = [Grp_SWD2,"ColorWEST","SWORD2","b_mech_inf",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_SWD3") then {0 = [Grp_SWD3,"ColorWEST","SWORD3","b_mech_inf",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_SWD4") then {0 = [Grp_SWD4,"ColorWEST","SWORD4","b_mech_inf",[0.8,0.8]] spawn ax_fnc_group_markers;};

	if !(isNil "Grp_HMR1") then {0 = [Grp_HMR1,"ColorWEST","HAMMER1","b_armor",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_HMR2") then {0 = [Grp_HMR2,"ColorWEST","HAMMER2","b_armor",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_HMR3") then {0 = [Grp_HMR3,"ColorWEST","HAMMER3","b_armor",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_HMR4") then {0 = [Grp_HMR4,"ColorWEST","HAMMER4","b_armor",[0.8,0.8]] spawn ax_fnc_group_markers;};

	//AIR /////////////////////////////////////////////////////////////////////////////////////////
	if !(isNil "Grp_FLC1") then {0 = [Grp_FLC1,"ColorEAST","","LAMBS_HELI",[1,1]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_FLC2") then {0 = [Grp_FLC2,"ColorWEST","","LAMBS_HELI",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_FLC3") then {0 = [Grp_FLC3,"ColorWEST","","LAMBS_HELI",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_FLC4") then {0 = [Grp_FLC4,"ColorWEST","","LAMBS_HELI",[0.8,0.8]] spawn ax_fnc_group_markers;};

	if !(isNil "Grp_CDR1") then {0 = [Grp_CDR1,"ColorEAST","","LAMBS_HELI",[1,1]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_CDR2") then {0 = [Grp_CDR2,"ColorWEST","","LAMBS_HELI",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_CDR3") then {0 = [Grp_CDR3,"ColorWEST","","LAMBS_HELI",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_CDR4") then {0 = [Grp_CDR4,"ColorWEST","","LAMBS_HELI",[0.8,0.8]] spawn ax_fnc_group_markers;};

	if !(isNil "Grp_HWK1") then {0 = [Grp_HWK1,"ColorWEST","","LAMBS_HELI",[1,1]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_HWK2") then {0 = [Grp_HWK2,"ColorWEST","","LAMBS_HELI",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_HWK3") then {0 = [Grp_HWK3,"ColorWEST","","LAMBS_HELI",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_HWK4") then {0 = [Grp_HWK4,"ColorWEST","","LAMBS_HELI",[0.8,0.8]] spawn ax_fnc_group_markers;};

	if !(isNil "Grp_EGL1") then {0 = [Grp_EGL1,"ColorWEST","","LAMBS_PLANE",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_EGL2") then {0 = [Grp_EGL2,"ColorWEST","","LAMBS_PLANE",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_EGL3") then {0 = [Grp_EGL3,"ColorWEST","","LAMBS_PLANE",[0.8,0.8]] spawn ax_fnc_group_markers;};
	if !(isNil "Grp_EGL4") then {0 = [Grp_EGL4,"ColorWEST","","LAMBS_PLANE",[0.8,0.8]] spawn ax_fnc_group_markers;};
};