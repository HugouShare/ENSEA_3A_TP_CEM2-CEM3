clc; clear; close all;

% 1) Simulation CRBM cavité vide
disp('Simulation CRBM cavité vide...');
E_vide = FDTD_crbm_vide();   % Nt x 3 matrice [Ex Ey Ez]

% Sauvegarde dans result_vide.txt
fid = fopen('result_vide.txt','w');
fprintf(fid,'%% Ex(V/m)\tEy(V/m)\tEz(V/m)\n');

for n = 1:size(E_vide,1)
    fprintf(fid,'%e\t%e\t%e\n',E_vide(n,1),E_vide(n,2),E_vide(n,3));
end

fclose(fid);

disp('result_vide.txt sauvegardé');

% 2) Simulation CRBM cavité chargée
disp('Simulation CRBM cavité chargée...');
E_chargee = FDTD_crbm_chargee();   % Nt x 3 matrice [Ex Ey Ez]

% Sauvegarde dans result_chargee.txt
fid = fopen('result_chargee.txt','w');
fprintf(fid,'%% Ex(V/m)\tEy(V/m)\tEz(V/m)\n');

for n = 1:size(E_chargee,1)
    fprintf(fid,'%e\t%e\t%e\n',E_chargee(n,1),E_chargee(n,2),E_chargee(n,3));
end

fclose(fid);

disp('result_chargee.txt sauvegardé');

