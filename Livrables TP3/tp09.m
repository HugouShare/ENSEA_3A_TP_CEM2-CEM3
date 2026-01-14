clc; clear; close all;

% Paramètres
Dt = 1e-10;           % Pas de temps
Nt = 400;             % Nombre d'itérations
Fs = 1/Dt;            % Fréquence d'échantillonnage
fmin = 80e6;          % 80 MHz
fmax = 150e6;         % 150 MHz

% 1) Chargement des résultats temporels
E_vide     = load('result_vide.txt');
E_chargee  = load('result_chargee.txt');

Ex_vide    = E_vide(:,1);
Ey_vide    = E_vide(:,2);
Ez_vide    = E_vide(:,3);

Ex_chargee = E_chargee(:,1);
Ey_chargee = E_chargee(:,2);
Ez_chargee = E_chargee(:,3);

% 2) FFT pour chaque composante
tfin = Nt*Dt;
Discret = 0:Nt-1;
Freq = Discret/tfin;  % Fréquence en Hz

FFT_Ex_vide    = abs(fft(Ex_vide)/Nt);
FFT_Ey_vide    = abs(fft(Ey_vide)/Nt);
FFT_Ez_vide    = abs(fft(Ez_vide)/Nt);

FFT_Ex_chargee = abs(fft(Ex_chargee)/Nt);
FFT_Ey_chargee = abs(fft(Ey_chargee)/Nt);
FFT_Ez_chargee = abs(fft(Ez_chargee)/Nt);

FFT_total_vide    = sqrt(FFT_Ex_vide.^2 + FFT_Ey_vide.^2 + FFT_Ez_vide.^2);
FFT_total_chargee = sqrt(FFT_Ex_chargee.^2 + FFT_Ey_chargee.^2 + FFT_Ez_chargee.^2);

% 3) Limite bande [80 MHz, 150 MHz]
idx_band = (Freq >= fmin) & (Freq <= fmax);
f_band = Freq(idx_band);

FFT_vide_band    = FFT_total_vide(idx_band);
FFT_chargee_band = FFT_total_chargee(idx_band);

% 4) Identification des fréquences de résonance
% On considère les maxima locaux
[~, loc_vide]    = findpeaks(FFT_vide_band, 'MinPeakHeight', max(FFT_vide_band)*0.1);
[~, loc_chargee] = findpeaks(FFT_chargee_band, 'MinPeakHeight', max(FFT_chargee_band)*0.1);

f_res_vide    = f_band(loc_vide);
f_res_chargee = f_band(loc_chargee);

% 5) Tracé
figure;
plot(f_band/1e6, 20*log10(FFT_vide_band),'b','LineWidth',1.2); hold on;
plot(f_band/1e6, 20*log10(FFT_chargee_band),'r','LineWidth',1.2);
grid on;
xlabel('Fréquence (MHz)');
ylabel('Amplitude (dB)');
title('Spectre fréquentiel CRBM [80MHz-150MHz]');
legend('Cavité vide','Cavité chargée');

% Marquer les pics
plot(f_res_vide/1e6, 20*log10(FFT_vide_band(loc_vide)),'bo','MarkerFaceColor','b');
plot(f_res_chargee/1e6, 20*log10(FFT_chargee_band(loc_chargee)),'ro','MarkerFaceColor','r');

% 6) Affichage des fréquences de résonance
disp('Fréquences de résonance cavité vide (MHz) :');
disp(f_res_vide/1e6);

disp('Fréquences de résonance cavité chargée (MHz) :');
disp(f_res_chargee/1e6);