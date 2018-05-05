% csv format
formatSpec = '%C%C%C%d%f';

% load csv
T = readtable(...
    '../../../data/anymal-stand/sample.csv', ...
    'Delimiter', ',', ...
    'Format',formatSpec ...
    );

% data from rai
RAI = T(T.SIM == 'RAI', :);
[RAI_G, RAI_numrows] = findgroups(RAI.NUMROW);
RAI_mins = splitapply(@min, RAI.TIME, RAI_G);

% data from bullet
BT = T(T.SIM == 'BULLET', :);
[BT_G, BT_numrows] = findgroups(BT.NUMROW);
BT_mins = splitapply(@min, BT.TIME, BT_G);

% data from dart-dantzig-bullet
DART_DAN_BT = T(...
    T.SIM == 'DART' ...
    & T.SOLVER == 'DANTZIG' ...
    & T.DETECTOR == 'BULLET', :);
[DART_DAN_BT_G, DART_DAN_BT_numrows] = findgroups(DART_DAN_BT.NUMROW);
DART_DAN_BT_mins = splitapply(...
    @min, ...
    DART_DAN_BT.TIME, ...
    DART_DAN_BT_G);

% data from dart-pgs-bullet
DART_PGS_BT = T(...
    T.SIM == 'DART' ...
    & T.SOLVER == 'PGS' ...
    & T.DETECTOR == 'BULLET', :);
[DART_PGS_BT_G, DART_PGS_BT_numrows] = findgroups(DART_PGS_BT.NUMROW);
DART_PGS_BT_mins = splitapply(...
    @min, ...
    DART_PGS_BT.TIME, ...
    DART_PGS_BT_G);

% data from dart-dantzig-ode
DART_DAN_ODE = T(...
    T.SIM == 'DART' ...
    & T.SOLVER == 'DANTZIG' ...
    & T.DETECTOR == 'ODE', :);
[DART_DAN_ODE_G, DART_DAN_ODE_numrows] = findgroups(DART_DAN_ODE.NUMROW);
DART_DAN_ODE_mins = splitapply(...
    @min, ...
    DART_DAN_ODE.TIME, ...
    DART_DAN_ODE_G);

% data from dart-pgs-ode
DART_PGS_ODE = T(...
    T.SIM == 'DART' ...
    & T.SOLVER == 'PGS' ...
    & T.DETECTOR == 'ODE', :);
[DART_PGS_ODE_G, DART_PGS_ODE_numrows] = findgroups(DART_PGS_ODE.NUMROW);
DART_PGS_ODE_mins = splitapply(...
    @min, ...
    DART_PGS_ODE.TIME, ...
    DART_PGS_ODE_G);

% data from mujoco-pgs
MJC_PGS = T(...
    T.SIM == 'MUJOCO' ...
    & T.SOLVER == 'PGS-NOSLIP', :);
[MJC_PGS_G, MJC_PGS_numrows] = findgroups(MJC_PGS.NUMROW);
MJC_PGS_mins = splitapply(...
    @min, ...
    MJC_PGS.TIME, ...
    MJC_PGS_G);

% data from mujoco-cg
MJC_CG = T(...
    T.SIM == 'MUJOCO' ...
    & T.SOLVER == 'CG-NOSLIP', :);
[MJC_CG_G, MJC_CG_numrows] = findgroups(MJC_CG.NUMROW);
MJC_CG_mins = splitapply(...
    @min, ...
    MJC_CG.TIME, ...
    MJC_CG_G);

% data from mujoco-newton
MJC_NEWTON = T(...
    T.SIM == 'MUJOCO' ...
    & T.SOLVER == 'NEWTON-NOSLIP', :);
[MJC_NEWTON_G, MJC_NEWTON_numrows] = findgroups(MJC_NEWTON.NUMROW);
MJC_NEWTON_mins = splitapply(...
    @min, ...
    MJC_NEWTON.TIME, ...
    MJC_NEWTON_G);

% data from ODE
ODE = T(T.SIM == 'ODE', :);
[ODE_G, ODE_numrows] = findgroups(ODE.NUMROW);
ODE_mins = splitapply(...
    @min, ...
    ODE.TIME, ...
    ODE_G);

% plot 
figure(1)
plot(RAI_numrows.^2, RAI_mins, 'g', 'DisplayName', 'Rai')
hold on 
plot(BT_numrows.^2, BT_mins, 'r', 'DisplayName', 'BtMultibody')
plot(DART_DAN_BT_numrows.^2, DART_DAN_BT_mins, '-mo', 'DisplayName', 'DartDantzig')
plot(DART_PGS_BT_numrows.^2, DART_PGS_BT_mins, '-m*', 'DisplayName', 'DartPGS')
plot(MJC_PGS_numrows.^2, MJC_PGS_mins, '-bs', 'DisplayName', 'MjcPGS')
plot(MJC_CG_numrows.^2, MJC_CG_mins, '-b*', 'DisplayName', 'MjcCG')
plot(MJC_NEWTON_numrows.^2, MJC_NEWTON_mins, '-bo', 'DisplayName', 'MjcNewton')
plot(ODE_numrows.^2, ODE_mins, 'y', 'DisplayName', 'OdeStd')
% plot(DART_DAN_ODE_numrows.^2, DART_DAN_ODE_mins, '-m.') % redundant 
% plot(DART_PGS_ODE_numrows.^2, DART_PGS_ODE_mins, '-mo') % redundant
xlabel('number of robots (n)')
ylabel('50k simulation time (sec)')
legend('Location', 'eastoutside')
title('ANYmal PD control test')
hold off

figure(2)
plot(RAI_numrows.^2, RAI_mins, 'g', 'DisplayName', 'Rai')
hold on 
plot(BT_numrows.^2, BT_mins, 'r', 'DisplayName', 'BtMultibody')
plot(DART_DAN_BT_numrows.^2, DART_DAN_BT_mins, '-mo', 'DisplayName', 'DartDantzig')
plot(DART_PGS_BT_numrows.^2, DART_PGS_BT_mins, '-m*', 'DisplayName', 'DartPGS')
plot(MJC_PGS_numrows.^2, MJC_PGS_mins, '-bs', 'DisplayName', 'MjcPGS')
plot(MJC_CG_numrows.^2, MJC_CG_mins, '-b*', 'DisplayName', 'MjcCG')
plot(MJC_NEWTON_numrows.^2, MJC_NEWTON_mins, '-bo', 'DisplayName', 'MjcNewton')
plot(ODE_numrows.^2, ODE_mins, 'y', 'DisplayName', 'OdeStd')
% plot(DART_DAN_ODE_numrows.^2, DART_DAN_ODE_mins, '-m.') % redundant 
% plot(DART_PGS_ODE_numrows.^2, DART_PGS_ODE_mins, '-mo') % redundant
xlabel('number of robots (log n)')
ylabel('50k simulation time (log sec)')
legend('Location', 'eastoutside')
hold off
title('ANYmal PD control test (log scale)')
set(gca, 'YScale', 'log', 'XScale', 'log')