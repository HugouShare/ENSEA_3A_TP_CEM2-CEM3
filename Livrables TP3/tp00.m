clc; clear; close all;

% 1) Paramètres physiques de la cavité
a = 0.3;      % Dimension selon x (m)
b = 0.2;      % Dimension selon y (m)
d = 0.1;      % Dimension selon z (m)

c = 3e8;      % Vitesse de la lumière dans le vide (m/s)

% 2) Paramètres de simulation
Mmax = 5;     % Indices m, n, p variant de 0 à 5

% Initialisation des tableaux de stockage
modes = [];        % Triplets (m,n,p)
frequences = [];   % Fréquences associées (Hz)

% 3) Génération de tous les triplets (m,n,p) et suppression des modes non physiques
for m = 0:Mmax
    for n = 0:Mmax
        for p = 0:Mmax
            
            % Condition de validité physique :
            % au moins deux indices non nuls
            nb_non_nuls = (m~=0) + (n~=0) + (p~=0);
            
            if nb_non_nuls >= 2
                
                % Calcul de la fréquence de résonance
                f = (c/2)*sqrt( (m/a)^2 + (n/b)^2 + (p/d)^2 );
                
                % Stockage
                modes = [modes; m n p];
                frequences = [frequences; f];
                
            end
        end
    end
end

% 4) Tri des modes par fréquence croissante
[frequences, idx] = sort(frequences);
modes = modes(idx,:);

% 5) Affichage des 10 premiers modes de résonance
disp('==============================================================')
disp('   m     n     p        f (Hz)')
disp('==============================================================')

N = min(10, length(frequences));

for k = 1:N
    fprintf('  %d     %d     %d     %8.3e \n', ...
        modes(k,1), modes(k,2), modes(k,3), frequences(k));
end

disp('==============================================================')

% 6) Représentation du spectre des fréquences
figure;
stem(frequences(1:N), 'filled');
xlabel('Indice du mode');
ylabel('Fréquence de résonance (Hz)');
title('Spectre des 10 premiers modes de résonance');
grid on;
