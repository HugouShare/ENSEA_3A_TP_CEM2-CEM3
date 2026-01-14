clc; clear; close all;

% 1) Paramètres temporels
Dt = 1e-10;      % Pas de temps (s) - identique aux scripts FDTD
Nt = 400;        % Nombre d'itérations

t = (0:Nt-1)*Dt; % Axe temporel

% 2) Chargement des résultats
E_vide     = load('result_vide.txt');
E_chargee = load('result_chargee.txt');

% 3) Tracé des champs électriques - cavité vide
figure;
plot(t, E_vide(:,1), 'r', 'LineWidth', 1.2); hold on;
plot(t, E_vide(:,2), 'b', 'LineWidth', 1.2);
plot(t, E_vide(:,3), 'k', 'LineWidth', 1.2);
grid on;

xlabel('Temps (s)');
ylabel('Champ électrique (V/m)');
title('Evolution temporelle du champ électrique - Cavité vide');
legend('E_x', 'E_y', 'E_z');

% 4) Tracé des champs électriques - cavité chargée
figure;
plot(t, E_chargee(:,1), 'r', 'LineWidth', 1.2); hold on;
plot(t, E_chargee(:,2), 'b', 'LineWidth', 1.2);
plot(t, E_chargee(:,3), 'k', 'LineWidth', 1.2);
grid on;

xlabel('Temps (s)');
ylabel('Champ électrique (V/m)');
title('Evolution temporelle du champ électrique - Cavité chargée');
legend('E_x', 'E_y', 'E_z');