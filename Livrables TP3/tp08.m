clc; clear; close all;

% Paramètre : pas de temps
Dt = 1e-10; 

% 1) FFT cavité vide
disp('Sélectionnez le fichier result_vide.txt pour la FFT...');
FFT_crbm(Dt);   % choisir le fichier

% 2) FFT cavité chargée
disp('Sélectionnez le fichier result_chargee.txt pour la FFT...');
FFT_crbm(Dt);   % choisir le fichier

disp('TP08 terminé : FFT réalisée pour cavité vide et chargée.');