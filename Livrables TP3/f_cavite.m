% f_cavite calcule la fréquence de résonance d'une cavité rectangulaire
function f = f_cavite(a, b, d, m, n, p)

% Entrées :
% a, b, d : dimensions de la cavité (m)
% m, n, p : indices de mode

% Sortie :
% f : fréquence de résonance (Hz)

c = 3e8; % vitesse de la lumière (m/s)

f = (c/2) * sqrt( (m/a)^2 + (n/b)^2 + (p/d)^2 );
end