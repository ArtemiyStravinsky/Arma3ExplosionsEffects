// Define the array of marker names
private _markerNames = _this select 0;

// Iterate through each marker name
{
    // Get the position of the current marker
    private _markerPos = getMarkerPos _x;
    private _aslPos = [_markerPos select 0, _markerPos select 1, getTerrainHeightASL _markerPos];

    // Create the explosion
    createVehicle ["Bo_GBU12_LGB", _aslPos, [], 0, "NONE"];

    // Wait a bit for the explosion effects to settle
    sleep 0.5;

    // Call the effects
    [_aslPos] call IED_ROCKS;
    [_aslPos, _aslPos, 10, 10] call SAND_TRAIL_SMOKE;
    [_aslPos, _aslPos, 10, 10] call GRAY_TRAIL_SMOKE;
    [_aslPos, _aslPos, 10, 10] call BROWN_TRAIL_SMOKE;
    [_aslPos, _aslPos, 10, 10] call IED_SMOKE_LARGE;
} forEach _markerNames;

/****************** EFFECT FUNCTIONS *********************/

// IED_ROCKS Effect
IED_ROCKS = {
    _loc = _this select 0;
    _aslLoc = [_loc select 0, _loc select 1, getTerrainHeightASL _loc];
    _col = [0,0,0];
    _c1 = _col select 0;
    _c2 = _col select 1;
    _c3 = _col select 2;

    _rocks1 = "#particlesource" createVehicleLocal _aslLoc;
    _rocks1 setposasl _aslLoc;
    _rocks1 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Mud.p3d", 1, 0, 1], "", "SpaceObject", 1, 12.5, [0, 0, 0], [0, 0, 15], 5, 100, 7.9, 1, [.45, .45], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _aslLoc, 0, false, 0.3];
    _rocks1 setParticleRandom [0, [1, 1, 0], [20, 20, 15], 3, 0.25, [0, 0, 0, 0.1], 0, 0];
    _rocks1 setDropInterval 0.01;
    _rocks1 setParticleCircle [0, [0, 0, 0]];

    _rocks2 = "#particlesource" createVehicleLocal _aslLoc;
    _rocks2 setposasl _aslLoc;
    _rocks2 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Mud.p3d", 1, 0, 1], "", "SpaceObject", 1, 12.5, [0, 0, 0], [0, 0, 15], 5, 100, 7.9, 1, [.27, .27], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _aslLoc, 0, false, 0.3];
    _rocks2 setParticleRandom [0, [1, 1, 0], [25, 25, 15], 3, 0.25, [0, 0, 0, 0.1], 0, 0];
    _rocks2 setDropInterval 0.01;
    _rocks2 setParticleCircle [0, [0, 0, 0]];

    _rocks3 = "#particlesource" createVehicleLocal _aslLoc;
    _rocks3 setposasl _aslLoc;
    _rocks3 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Mud.p3d", 1, 0, 1], "", "SpaceObject", 1, 12.5, [0, 0, 0], [0, 0, 15], 5, 100, 7.9, 1, [.09, .09], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.08], 1, 0, "", "", _aslLoc, 0, false, 0.3];
    _rocks3 setParticleRandom [0, [1, 1, 0], [30, 30, 15], 3, 0.25, [0, 0, 0, 0.1], 0, 0];
    _rocks3 setDropInterval 0.01;
    _rocks3 setParticleCircle [0, [0, 0, 0]];

    _rocks = [_rocks1, _rocks2, _rocks3];
    sleep 0.125;
    {
        deleteVehicle _x;
    } forEach _rocks;
};

// SAND_TRAIL_SMOKE Effect
SAND_TRAIL_SMOKE = {
    _loc = _this select 0;
    _aslLoc = _this select 1;
    _horizontal = _this select 2;
    _upwards = _this select 3;

    _size = 1 + random 3;

    _thingToFling = "Land_Bucket_F" createVehicleLocal [0, 0, 0];
    _thingToFling hideObject true;
    _thingToFling setPos _loc;
    _smoke = "#particlesource" createVehicleLocal _aslLoc;
    _smoke setposasl _aslLoc;
    _smoke setParticleCircle [0, [0, 0, 0]];
    _smoke setParticleRandom [0, [0.25, 0.25, 0], [0, 0, 0], 0, 1, [0, 0, 0, 0.1], 0, 0];
    _smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size, 2 * _size], [[0.55, 0.47, 0.37, 0.75], [0.78, 0.76, 0.71, 0]], [0.08], 1, 0, "", "", _thingToFling];
    _smoke setDropInterval 0.005;

    _thingToFling setVelocity [(random _horizontal) - (_horizontal / 2), (random _horizontal) - (_horizontal / 2), 5 + (random _upwards)];
    _thingToFling allowDamage false;
    _sleepTime = (random 0.5);
    _currentTime = 0;

    while {_currentTime < _sleepTime and _size > 0} do {
        _smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size, 2 * _size], [[0.55, 0.47, 0.37, 0.75], [0.78, 0.76, 0.71, 0]], [0.08], 1, 0, "", "", _thingToFling];

        _sleep = random 0.05;
        _size = _size - (6 * _sleep);
        _currentTime = _currentTime + _sleep;
        sleep _sleep;
    };

    _thingToFling setPos [0, 0, 0];
    deleteVehicle _smoke;
    deleteVehicle _thingToFling;
};

// Define other effects in a similar manner

GRAY_TRAIL_SMOKE = {
    _loc = _this select 0;
    _aslLoc = _this select 1;
    _horizontal = _this select 2;
    _upwards = _this select 3;

    _size = 1 + random 3;

    _thingToFling = "Land_Bucket_F" createVehicleLocal [0, 0, 0];
    _thingToFling hideObject true;
    _thingToFling setPos _loc;
    _smoke = "#particlesource" createVehicleLocal _aslLoc;
    _smoke setposasl _aslLoc;
    _smoke setParticleCircle [0, [0, 0, 0]];
    _smoke setParticleRandom [0, [0.25, 0.25, 0], [0, 0, 0], 0, 1, [0, 0, 0, 0.1], 0, 0];
    _smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size, 2 * _size], [[0.1, 0.1, 0.1, 0.75], [0.78, 0.76, 0.71, 0]], [0.08], 1, 0, "", "", _thingToFling];
    _smoke setDropInterval 0.005;

    _thingToFling setVelocity [(random _horizontal) - (_horizontal / 2), (random _horizontal) - (_horizontal / 2), 5 + (random _upwards)];
    _thingToFling allowDamage false;
    _sleepTime = (random 0.5);
    _currentTime = 0;

    while {_currentTime < _sleepTime and _size > 0} do {
        _smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size, 2 * _size], [[0.1, 0.1, 0.1, 0.75], [0.78, 0.76, 0.71, 0]], [0.08], 1, 0, "", "", _thingToFling];

        _sleep = random 0.05;
        _size = _size - (6 * _sleep);
        _currentTime = _currentTime + _sleep;
        sleep _sleep;
    };

    _thingToFling setPos [0, 0, 0];
    deleteVehicle _smoke;
    deleteVehicle _thingToFling;
};

// BROWN_TRAIL_SMOKE Effect
BROWN_TRAIL_SMOKE = {
    _loc = _this select 0;
    _aslLoc = _this select 1;
    _horizontal = _this select 2;
    _upwards = _this select 3;

    _size = 1 + random 3;

    _thingToFling = "Land_Bucket_F" createVehicleLocal [0, 0, 0];
    _thingToFling hideObject true;
    _thingToFling setPos _loc;
    _smoke = "#particlesource" createVehicleLocal _aslLoc;
    _smoke setposasl _aslLoc;
    _smoke setParticleCircle [0, [0, 0, 0]];
    _smoke setParticleRandom [0, [0.25, 0.25, 0], [0, 0, 0], 0, 1, [0, 0, 0, 0.1], 0, 0];
    _smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size, 2 * _size], [[0.55, 0.41, 0.25, 1], [0.55, 0.41, 0.25, 0]], [0.08], 1, 0, "", "", _thingToFling];
    _smoke setDropInterval 0.005;

    _thingToFling setVelocity [(random _horizontal) - (_horizontal / 2), (random _horizontal) - (_horizontal / 2), 5 + (random _upwards)];
    _thingToFling allowDamage false;
    _sleepTime = (random 0.5);
    _currentTime = 0;

    while {_currentTime < _sleepTime and _size > 0} do {
        _smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 2], [0, 0, 0], 0, 10, 7.85, 0.375, [_size, 2 * _size], [[0.55, 0.41, 0.25, 1], [0.55, 0.41, 0.25, 0]], [0.08], 1, 0, "", "", _thingToFling];

        _sleep = random 0.05;
        _size = _size - (6 * _sleep);
        _currentTime = _currentTime + _sleep;
        sleep _sleep;
    };

    _thingToFling setPos [0, 0, 0];
    deleteVehicle _smoke;
    deleteVehicle _thingToFling;
};

IED_SMOKE_LARGE = {
    _loc = _this select 0;
    _aslLoc = [_loc select 0, _loc select 1, getTerrainHeightASL [_loc select 0, _loc select 1]];
    
    0 = [_loc] spawn SHOCK_WAVE;
    
    0 = [_loc, _aslLoc] spawn {
        _loc = _this select 0;
        _aslLoc = _this select 1;
        _numPlumes = 15 + floor random 20;
        for "_i" from 0 to _numPlumes - 1 do {
            _r = floor random 3;
            switch(_r) do {
                case 0: {
                    [_loc, _aslLoc, 500, 200] spawn {call SAND_TRAIL_SMOKE;};
                };
                case 1: {
                    [_loc, _aslLoc, 500, 200] spawn {call GRAY_TRAIL_SMOKE;};
                };
                case 2: {
                    [_loc, _aslLoc, 500, 200] spawn {call BROWN_TRAIL_SMOKE;};
                };
            };
        };
    };
        
    0 = _aslLoc spawn {
    
        _aslLoc = _this;
        
        _smoke1 = "#particlesource" createVehicleLocal _aslLoc;
        _smoke1 setposasl _aslLoc;
        _smoke1 setParticleCircle [0, [0, 0, 0]];
        _smoke1 setParticleRandom [0, [1.5 + random 3, 1.5 + random 3, 8], [8 + random 5, 8 + random 5, 15], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
        _smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 6, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[0, 0, 0, 1], [0.35, 0.35, 0.35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
        _smoke1 setDropInterval .005;
        
        _smoke2 = "#particlesource" createVehicleLocal _aslLoc;
        _smoke2 setposasl _aslLoc;
        _smoke2 setParticleCircle [0, [0, 0, 0]];
        _smoke2 setParticleRandom [0, [1.5 + random 3, 1.5 + random 3, 8], [8 + random 5, 8 + random 5, 15], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
        _smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 6, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.78, .76, .71, 1], [.35, .35, .35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
        _smoke2 setDropInterval .005;
        
        _smoke3 = "#particlesource" createVehicleLocal _aslLoc;
        _smoke3 setposasl _aslLoc;
        _smoke3 setParticleCircle [0, [0, 0, 0]];
        _smoke3 setParticleRandom [0, [1.5 + random 3, 1.5 + random 3, 8], [8 + random 5, 8 + random 5, 15], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
        _smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 6, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.55, .47, .37, 1], [.35, .35, .35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
        _smoke3 setDropInterval .005;
        
        _smoke4 = "#particlesource" createVehicleLocal _aslLoc;
        _smoke4 setposasl _aslLoc;
        _smoke4 setParticleCircle [0, [0, 0, 0]];
        _smoke4 setParticleRandom [0, [1.5 + random 3, 1.5 + random 3, 8], [8 + random 5, 8 + random 5, 15], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
        _smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 6, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.1, .1, .1, 1], [.2, .2, .2, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
        _smoke4 setDropInterval .005;
        
        _smokes = [_smoke1, _smoke2, _smoke3, _smoke4];

sleep .5;
		
		_smoke1 setParticleRandom [0, [3 + random 4, 3 + random 4, 5], [8+random 5, 8+random 5, 5], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 14, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke1 setDropInterval .005;
		
		_smoke2 setParticleRandom [0, [3 + random 4, 3 + random 4, 5], [8+random 5, 8+random 5, 5], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 14, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke2 setDropInterval .005;
		
		_smoke3 setParticleRandom [0, [3 + random 4, 3 + random 4, 5], [8+random 5, 8+random 5, 5], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 14, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke3 setDropInterval .005;
		
		_smoke4 setParticleRandom [0, [3 + random 4, 3 + random 4, 5], [8+random 5, 8+random 5, 5], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 14, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke4 setDropInterval .005;
		
		sleep 1;
		
		_smoke1 setParticleRandom [0, [5 + random 5, 5 + random 5, 5], [2+random 5, 2+random 5, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 25, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke1 setDropInterval .005;
		
		_smoke2 setParticleRandom [0, [5 + random 5, 5 + random 5, 5], [2+random 5, 2+random 5, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 25, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke2 setDropInterval .005;
		
		_smoke3 setParticleRandom [0, [5 + random 5, 5 + random 5, 5], [2+random 5, 2+random 5, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 25, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke3 setDropInterval .005;
		
		_smoke4 setParticleRandom [0, [5 + random 5, 5 + random 5, 5], [2+random 5, 2+random 5, 1], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 25, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke4 setDropInterval .005;
		
		sleep 1;
		
		_smoke1 setParticleRandom [0, [10 + random 5, 10 + random 5, 10], [4.5, 4.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 35, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke1 setDropInterval .01;
		
		_smoke2 setParticleRandom [0, [10 + random 5, 10 + random 5, 10], [4.5, 4.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 35, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke2 setDropInterval .01;
		
		_smoke3 setParticleRandom [0, [10 + random 5, 10 + random 5, 10], [4.5, 4.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 35, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke3 setDropInterval .01;
		
		_smoke4 setParticleRandom [0, [10 + random 5, 10 + random 5, 10], [4.5, 4.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 35, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke4 setDropInterval .01;
		
		sleep 1;
		
		_smoke1 setParticleRandom [0, [15 + random 10, 15 + random 10, 8], [1.5, 1.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 45, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke1 setDropInterval .01;
		
		_smoke2 setParticleRandom [0, [15 + random 10, 15 + random 10, 8], [1.5, 1.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 45, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke2 setDropInterval .01;
		
		_smoke3 setParticleRandom [0, [15 + random 10, 15 + random 10, 8], [1.5, 1.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 45, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke3 setDropInterval .01;
		
		_smoke4 setParticleRandom [0, [15 + random 10, 15 + random 10, 8], [1.5, 1.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
		_smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 45, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, .375, [6 + random 4, 10 + random 4, 14 + random 4], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
		_smoke4 setDropInterval .01;
		
		sleep 2;
		{
			deletevehicle _x;
		} foreach _smokes;

	};
};

IED_SMOKE_MEDIUM = {
    _loc = _this select 0;
    _aslLoc = [_loc select 0, _loc select 1, getTerrainHeightASL [_loc select 0, _loc select 1]];
    
    0 = [_loc] spawn SHOCK_WAVE;
    
    0 = [_loc, _aslLoc] spawn {
        _loc = _this select 0;
        _aslLoc = _this select 1;
        _numPlumes = 10 + floor random 15;
        for "_i" from 0 to _numPlumes - 1 do {
            _r = floor random 3;
            switch(_r) do {
                case 0: {
                    [_loc, _aslLoc, 300, 150] spawn {call SAND_TRAIL_SMOKE;};
                };
                case 1: {
                    [_loc, _aslLoc, 300, 150] spawn {call GRAY_TRAIL_SMOKE;};
                };
                case 2: {
                    [_loc, _aslLoc, 300, 150] spawn {call BROWN_TRAIL_SMOKE;};
                };
            };
        };
    };
        
    0 = _aslLoc spawn {
    
        _aslLoc = _this;
        
        _smoke1 = "#particlesource" createVehicleLocal _aslLoc;
        _smoke1 setposasl _aslLoc;
        _smoke1 setParticleCircle [0, [0, 0, 0]];
        _smoke1 setParticleRandom [0, [1.5 + random 2, 1.5 + random 2, 6], [6 + random 4, 6 + random 4, 10], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
        _smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 4, [0, 0, 0], [0, 0, 0], 0, 8, 7.85, .375, [4 + random 3, 8 + random 3, 12 + random 3], [[0, 0, 0, 1], [0.35, 0.35, 0.35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
        _smoke1 setDropInterval .005;
        
        _smoke2 = "#particlesource" createVehicleLocal _aslLoc;
        _smoke2 setposasl _aslLoc;
        _smoke2 setParticleCircle [0, [0, 0, 0]];
        _smoke2 setParticleRandom [0, [1.5 + random 2, 1.5 + random 2, 6], [6 + random 4, 6 + random 4, 10], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
        _smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 4, [0, 0, 0], [0, 0, 0], 0, 8, 7.85, .375, [4 + random 3, 8 + random 3, 12 + random 3], [[.78, .76, .71, 1], [.35, .35, .35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
        _smoke2 setDropInterval .005;
        
        _smoke3 = "#particlesource" createVehicleLocal _aslLoc;
        _smoke3 setposasl _aslLoc;
        _smoke3 setParticleCircle [0, [0, 0, 0]];
        _smoke3 setParticleRandom [0, [1.5 + random 2, 1.5 + random 2, 6], [6 + random 4, 6 + random 4, 10], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
        _smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 4, [0, 0, 0], [0, 0, 0], 0, 8, 7.85, .375, [4 + random 3, 8 + random 3, 12 + random 3], [[.55, .47, .37, 1], [.35, .35, .35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
        _smoke3 setDropInterval .005;
        
        _smoke4 = "#particlesource" createVehicleLocal _aslLoc;
        _smoke4 setposasl _aslLoc;
        _smoke4 setParticleCircle [0, [0, 0, 0]];
        _smoke4 setParticleRandom [0, [1.5 + random 2, 1.5 + random 2, 6], [6 + random 4, 6 + random 4, 10], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
        _smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 4, [0, 0, 0], [0, 0, 0], 0, 8, 7.85, .375, [4 + random 3, 8 + random 3, 12 + random 3], [[.1, .1, .1, 1], [.2, .2, .2, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
        _smoke4 setDropInterval .005;
        
        _smokes = [_smoke1, _smoke2, _smoke3, _smoke4];
        
        sleep .5;
        
        _smoke1 setParticleRandom [0, [2 + random 3, 2 + random 3, 4], [6 + random 4, 6 + random 4, 4], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
        _smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 0], [0, 0, 0], 0, 8, 7.85, .375, [4 + random 3, 8 + random 3, 12 + random 3], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
        _smoke1 setDropInterval .005;
        
        _smoke2 setParticleRandom [0, [2 + random 3, 2 + random 3, 4], [6 + random 4, 6 + random 4, 4], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
        _smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 0], [0, 0, 0], 0, 8, 7.85, .375, [4 + random 3, 8 + random 3, 12 + random 3], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
        _smoke2 setDropInterval .005;
        
        _smoke3 setParticleRandom [0, [2 + random 3, 2 + random 3, 4], [6 + random 4, 6 + random 4, 4], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
        _smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 0], [0, 0, 0], 0, 8, 7.85, .375, [4 + random 3, 8 + random 3, 12 + random 3], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
        _smoke3 setDropInterval .005;
        
        _smoke4 setParticleRandom [0, [2 + random 3, 2 + random 3, 4], [6 + random 4, 6 + random 4, 4], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
        _smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 10, [0, 0, 0], [0, 0, 0], 0, 8, 7.85, .375, [4 + random 3, 8 + random 3, 12 + random 3], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
        _smoke4 setDropInterval .005;
        
        sleep 1;
        
        _smoke1 setParticleRandom [0, [6 + random 5, 6 + random 5, 6], [3 + random 4, 3 + random 4, 2], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
        _smoke1 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 20, [0, 0, 0], [0, 0, 0], 0, 8, 7.85, .375, [4 + random 3, 8 + random 3, 12 + random 3], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
        _smoke1 setDropInterval .01;
        
        _smoke2 setParticleRandom [0, [6 + random 5, 6 + random 5, 6], [3 + random 4, 3 + random 4, 2], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
        _smoke2 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 20, [0, 0, 0], [0, 0, 0], 0, 8, 7.85, .375, [4 + random 3, 8 + random 3, 12 + random 3], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
        _smoke2 setDropInterval .01;
        
        _smoke3 setParticleRandom [0, [6 + random 5, 6 + random 5, 6], [3 + random 4, 3 + random 4, 2], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
        _smoke3 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 20, [0, 0, 0], [0, 0, 0], 0, 8, 7.85, .375, [4 + random 3, 8 + random 3, 12 + random 3], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
        _smoke3 setDropInterval .01;
        
        _smoke4 setParticleRandom [0, [6 + random 5, 6 + random 5, 6], [3 + random 4, 3 + random 4, 2], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
        _smoke4 setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 20, [0, 0, 0], [0, 0, 0], 0, 8, 7.85, .375, [4 + random 3, 8 + random 3, 12 + random 3], [[.35, .35, .35, 1], [.2, .2, .2, 0.5], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
        _smoke4 setDropInterval .01;
        
        sleep 1;
        
        {
            deleteVehicle _x;
        } forEach _smokes;
        
    };
};

IED_SMOKE_SMALL = {
    _loc = _this select 0;
    _aslLoc = [_loc select 0, _loc select 1, getTerrainHeightASL [_loc select 0, _loc select 1]];
    
    0 = [_loc, _aslLoc] spawn {
        _loc = _this select 0;
        _aslLoc = _this select 1;
        _numPlumes = floor random 8;
        
        for "_i" from 0 to _numPlumes - 1 do {
            _r = floor random 3;
            switch (_r) do {
                case 0: { [_loc, _aslLoc, 500, 200] spawn SAND_TRAIL_SMOKE; };
                case 1: { [_loc, _aslLoc, 500, 200] spawn GRAY_TRAIL_SMOKE; };
                case 2: { [_loc, _aslLoc, 500, 200] spawn BROWN_TRAIL_SMOKE; };
            };
        };
    };
    
    0 = _aslLoc spawn {
        _aslLoc = _this;
        
        private _smokes = [];
        for "_i" from 1 to 4 do {
            private _smoke = "#particlesource" createVehicleLocal _aslLoc;
            _smoke setposasl _aslLoc;
            _smoke setParticleCircle [0, [0, 0, 0]];
            _smoke setParticleRandom [0, [1.5 + random 2, 1.5 + random 2, 8], [1 + random 5, 1 + random 5, 15], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
            private _color = switch (_i) do {
                case 1: { [0, 0, 0, 1] };
                case 2: { [0.78, 0.76, 0.71, 1] };
                case 3: { [0.55, 0.47, 0.37, 1] };
                default { [0.1, 0.1, 0.1, 1] };
            };
            _smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 6, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, 0.375, [6 + random 4, 10 + random 4, 14 + random 4], [_color, [0.35, 0.35, 0.35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
            _smoke setDropInterval 0.01;
            _smokes pushBack _smoke;
        };
        
        sleep 1;
        
        {
            _x setParticleRandom [0, [1.5 + random 2, 1.5 + random 2, 5], [1 + random 5, 1 + random 5, 10], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
            _x setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 9, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, 0.375, [6 + random 4, 10 + random 4, 14 + random 4], [[0.35, 0.35, 0.35, 1], [0.2, 0.2, 0.2, 0.9], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
            _x setDropInterval 0.03;
        } forEach _smokes;
        
        sleep 1;
        
        {
            _x setParticleRandom [0, [1 + random 3, 1 + random 3, 5], [1, 1, 4], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
            _x setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 16, [0, 0, 0], [0, 0, 0], 0, 10, 7.85, 0.375, [6 + random 4, 10 + random 4, 14 + random 4], [[0.35, 0.35, 0.35, 1], [0.2, 0.2, 0.2, 0.9], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
            _x setDropInterval 0.05;
        } forEach _smokes;
        
        sleep 2;
        
        {
            deleteVehicle _x;
        } forEach _smokes;
    };
};

SHOCK_WAVE = {
    _loc = _this select 0;
    _aslLoc = [_loc select 0, _loc select 1, getTerrainHeightASL [_loc select 0, _loc select 1]];
    
    private _smokes = [];
    for "_i" from 1 to 4 do {
        private _smoke = "#particlesource" createVehicleLocal _aslLoc;
        _smoke setposasl _aslLoc;
        _smoke setParticleCircle [0, [0, 0, 0]];
        _smoke setParticleRandom [0, [8, 8, 2], [300, 300, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.1], 0, 0];
        private _color = switch (_i) do {
            case 1: { [0, 0, 0, 1] };
            case 2: { [0.78, 0.76, 0.71, 1] };
            case 3: { [0.55, 0.47, 0.37, 1] };
            default { [0.1, 0.1, 0.1, 1] };
        };
        _smoke setParticleParams [["\A3\data_f\cl_fireD", 1, 0, 1], "", "Billboard", 1, 3, [0, 0, -1], [0, 0, -8], 0, 10, 7.85, 0.375, [6, 8, 10], [_color, [0.35, 0.35, 0.35, 0.35], [0.35, 0.35, 0.35, 0]], [0.08], 1, 0, "", "", _aslLoc];
        _smoke setDropInterval 0.0004;
        _smokes pushBack _smoke;
    };
    
    sleep 0.07;
    
    {
        deleteVehicle _x;
    } forEach _smokes;
};


