 function [uLabSpace, xLabSpace, tLabSpace] = modl3(cCa, diffRateMonomer, Nc, k)
% Coupled diffusion-reaction model for alginate gelling in a cylindrical
% coordinate system. Inputs are the physical parameters:
% - cCa: CaCl2 concentration in M
% - diffRateMonomer: Ungelled alginate diffusion coefficient. In SI units
% - Nc: Number of Ca++ ions bound per monomer
% - k: Reaction rate constant in SI units
% Other physical parameters are fixed.
% uLabSpace(t,x,z) contains concentration of component z at time t at
% position x. Where z=1 is Ca++, z=2 is ungelled alginate and z=3 is gelled
% alginate. X and t are nondimensional. xLabSpace is position x in lab
% space and tLabSpace is time t in lab space



% ---------Physical values---------------
h = 1.5e-3; % Droplet Radius in meters
cMonomer = .10; % Monomer concentration (fixed) - see lab book pg 41
cGel = 0;   % Gel concentration (fixed)
diffRateCalcium = 1e-9;   % in free solution same as before because of reduction in Braschler
%---------------------------------------


% ------------Model parameters ----------
tEnd = 1200;   % Simulation end time in seconds
H = 0.2;      % Relative bead size. Container size is (bead size)/H % Factor calculated in lab book pg 41
m = 1;        % Geometry of problem  0 for slab, 1 for disc, 2 for sphere

Ac = 100;     % Critical conc for monomer diffusion function
Gc = 100;     % Critical conc for monomer diffusion function

XMESH = 1000; % Mesh size for distance.  values between 200(fastest) and 1000(more stable at edges)
TMESH = 301;  % Mesh size for time.
% ----------------------------------------


% ---- Calculating nondimensional quantities ----
%   Monomer concentration is set as reference concentration. All 
%   dimensionless quantities are calculated as shown in Mikkelsen(1995)
cr = cMonomer;  % Reference concentration                                                           
C = cCa/cr;                                                               
A = cMonomer/cr; 
G = cGel/cr;
T = (tEnd*diffRateCalcium)/(h^2);                                           
D = diffRateMonomer/diffRateCalcium;
K = (k*h^2*cr^2)/diffRateCalcium;
%-----------------------------------------------


% ---- Generating Mesh for PDE ----
t = linspace(0,T,TMESH);    % Non-dim
x = linspace(0,1/H,XMESH);  % Non-dim
% ---------------------------------

% ---- Solving PDE ----
% Solution of PDE, u(t,x,z) is a matrix containing relative concentrations
% of the Ca2+, monomer and gel phases. z = 1 is Ca2+, z = 2 is unreacted 
% alginate, z = 3 is gel

u = pdepe(m,@diffEq,@initCond,@boundCond,x,t);
% ---------------------


% ---- Converting to lab space  ---- 
 xLabSpace = x*h;    % Convert distance to lab space
 uLabSpace = u*cr;   % Convert concentration to lab space
 tLabSpace = h^2*t/diffRateCalcium;  % Time in lab space
% ---------------------------------


% Calclulates monomer diffusion rate. From From Eq(35), Mikkelsen(1995)
function DAG = monomerDiffRate(monomerConc,gelConc)  
    DAG = D*exp(-monomerConc/Ac)*exp(-gelConc/Gc);    
end
 
% The differential equation to solve. Each column corresponds to one 
% component. [Ca2+; Ungelled: Gelled]
function [c,f,s] = diffEq(x,t,u,DuDx)
    DAG = monomerDiffRate(u(2),u(3)); 
    c = [1; 1; 1];
    f = [DuDx(1); DAG*DuDx(2); 0];
    s = [-Nc*K*u(1)*u(2)*(u(2)+u(3)); -K*u(1)*u(2)*(u(2)+u(3)); K*u(1)*u(2)*(u(2)+u(3))];
end

% Initial conditions.
function u0 = initCond(x) 
    outside = [C; 0; 0]*ones(1,length(x)); % Only Ca++ outside
    inside = [0; A; G]*ones(1, length(x)); % Only Alginate and gel inside
    u0 = [inside(:,x <= 1) outside(:,x > 1)]; % x=1 is edge of bubble
end


% Boundary conditions  l = left, r = right
% - Free: p = 0, q = 1
% - Fixed: p = u-concentration, q = 0
function [pl,ql,pr,qr] = boundCond(xl,ul,xr,ur,t)   %%% currentfly free-free
    pl = [0 0 0]';
    ql = [1 1 1]';
    pr = [0 0 0]';
    qr = [1 1 1]';
end

 end %function
