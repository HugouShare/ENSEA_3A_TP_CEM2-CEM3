function [Ets] = FDTD_crbm_vide()
% Constantes physiques
eps0 = 8.8541878e-12;
mu0  = 4e-7*pi;

% Dimensions de la cavité et discrétisation
Lx = 6.7; Ly = 8.4; Lz = 3.5;
delta = 0.1;

Nx = round(Lx/delta);
Ny = round(Ly/delta);
Nz = round(Lz/delta);

Cx = 1/delta;
Cy = 1/delta;
Cz = 1/delta;

Nt = 400;
Dt = 1e-10;

% Champs électromagnétiques
Ex = zeros(Nx  , Ny+1, Nz+1);
Ey = zeros(Nx+1, Ny  , Nz+1);
Ez = zeros(Nx+1, Ny+1, Nz  );

Hx = zeros(Nx+1, Ny  , Nz  );
Hy = zeros(Nx  , Ny+1, Nz  );
Hz = zeros(Nx  , Ny  , Nz+1);

EPS_X = eps0 * ones(size(Ex));
EPS_Y = eps0 * ones(size(Ey));
EPS_Z = eps0 * ones(size(Ez));

SIGMA_X = zeros(size(Ex));
SIGMA_Y = zeros(size(Ey));
SIGMA_Z = zeros(size(Ez));

% Coefficients FDTD
KE0X = (2*EPS_X)./(2*EPS_X);
KE1X = (2*Dt)./(2*EPS_X);

KE0Y = (2*EPS_Y)./(2*EPS_Y);
KE1Y = (2*Dt)./(2*EPS_Y);

KE0Z = (2*EPS_Z)./(2*EPS_Z);
KE1Z = (2*Dt)./(2*EPS_Z);

% Source et point d’observation
xi = 6; yi = 6; zi = 6;
xo = 6; yo = 11; zo = 6;

t0 = 8.761e-9;
sigma = 2e-9;
nfin = 93;

Ets = zeros(Nt,3);

% Boucle temporelle FDTD
for n = 1:Nt

    % --- Mise à jour de H ---
    Hx = Hx + (Dt/mu0)*((Ey(:,:,2:Nz+1)-Ey(:,:,1:Nz))*Cz ...
                      - (Ez(:,2:Ny+1,:)-Ez(:,1:Ny,:))*Cy);

    Hy = Hy + (Dt/mu0)*((Ez(2:Nx+1,:,:)-Ez(1:Nx,:,:))*Cx ...
                      - (Ex(:,:,2:Nz+1)-Ex(:,:,1:Nz))*Cz);

    Hz = Hz + (Dt/mu0)*((Ex(:,2:Ny+1,:)-Ex(:,1:Ny,:))*Cy ...
                      - (Ey(2:Nx+1,:,:)-Ey(1:Nx,:,:))*Cx);

    % --- Source ---
    if n <= nfin
        src = exp(-(n*Dt - t0)^2 / sigma^2);
        Ex(xi,yi,zi) = src;
        Ey(xi,yi,zi) = src;
        Ez(xi,yi,zi) = src;
    end

    % --- Mise à jour de E ---
    Ex(:,2:Ny,2:Nz) = KE0X(:,2:Ny,2:Nz).*Ex(:,2:Ny,2:Nz) ...
        + KE1X(:,2:Ny,2:Nz).*(Hz(:,2:Ny,2:Nz)-Hz(:,1:Ny-1,2:Nz))*Cy ...
        - KE1X(:,2:Ny,2:Nz).*(Hy(:,2:Ny,2:Nz)-Hy(:,2:Ny,1:Nz-1))*Cz;

    Ey(2:Nx,:,2:Nz) = KE0Y(2:Nx,:,2:Nz).*Ey(2:Nx,:,2:Nz) ...
        + KE1Y(2:Nx,:,2:Nz).*(Hx(2:Nx,:,2:Nz)-Hx(2:Nx,:,1:Nz-1))*Cz ...
        - KE1Y(2:Nx,:,2:Nz).*(Hz(2:Nx,:,2:Nz)-Hz(1:Nx-1,:,2:Nz))*Cx;

    Ez(2:Nx,2:Ny,:) = KE0Z(2:Nx,2:Ny,:).*Ez(2:Nx,2:Ny,:) ...
        + KE1Z(2:Nx,2:Ny,:).*(Hy(2:Nx,2:Ny,:)-Hy(1:Nx-1,2:Ny,:))*Cx ...
        - KE1Z(2:Nx,2:Ny,:).*(Hx(2:Nx,2:Ny,:)-Hx(2:Nx,1:Ny-1,:))*Cy;

    % --- Échantillonnage ---
    Ets(n,:) = [Ex(xo,yo,zo), Ey(xo,yo,zo), Ez(xo,yo,zo)];
end
end
