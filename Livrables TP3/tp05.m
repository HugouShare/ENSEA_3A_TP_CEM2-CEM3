clc; clear; close all;

% Simulation cavité vide
E_vide = FDTD_crbm_vide();
save('Ets_crbm_vide.mat','E_vide');

% Simulation cavité chargée
E_chargee = FDTD_crbm_chargee();
save('Ets_crbm_chargee.mat','E_chargee');

% Comparaison temporelle
figure;
plot(E_vide(:,1),'b'); hold on;
plot(E_chargee(:,1),'r');
grid on;
xlabel('Itération temporelle');
ylabel('Ex (V/m)');
legend('CRBM vide','CRBM chargée');
title('Comparaison du champ électrique Ex');
