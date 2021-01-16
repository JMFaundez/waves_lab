clc
clear all

%% Use  only radians / meters / seconds for all units.


%% Theory
load('LinTheory_F150')  %linear theory results 
%uBI ==> Branch 1 TS amplitude
% uBII ==> Branch 2 TS amplitude
% eta_BI & eta_BII==> non-dimensional y. To get y/delta_1 = eta_BI/1.7208 for blasius


[~, fp, fpp, fppp, eta] = FS_solver_JF(0);  % blasius solver fp=U/Uinf & eta=y/delta. 
% If you need y/delta_1 = (y/delta)*(delta/delta_1) = eta/1.7208 for blasius.

%% Use the values you have noted down during your lab session
Uinf=6.06;
nu=1.51e-5;
f=57 ; %Hz


%% generate figure 1 : growth curve (gc)
% use 'U6_growth_curve.txt' to plot growth factor ln(A/A0) vs X
% in this text file only read X ==> column 2 is X (mm), Amp ==> column 7 for TS amplitude (m/s)

figure(1),clf
plot(1.7208*sqrt(Rex),log(Amp/min(Amp)),'o')  %exp  Rex=X U/nu
hold on
 plot(Red,Nfac,'k-','LineWidth',2)   %lin theory

%% generate Figure 2 - velocity profiles at Branch 1
% Use 'U6_XBI_velocity.txt' file for branch 1
% here y-vector (mm) ==> 3rd column
% Umean (m/s) ==> 5th column
% A_TS (m/s) ==> 7th column (TS wave amlitude)
% phase (degrees) ==>  8th column
 
y=flipud(y);
Umean=flipud(Umean); % ... repeat for A_TS, phase

% Use flipud to flip the vectors A_TS, y, Umean, phase ( it means the
% direction measurent from close to the wall to free-stream)

 [Ywall,~]=TS_LAB_JF_P1(y,Umean);  % get Ywall
    
 
  y= y - Ywall; %  subtract Ywall from y-vector
    
   Uf = mean(Umean(end-5:end)); %local free-stream speed 
   
     
   % delta_1 : use trapz to find the displacement thickness 
   % add no-slip condition (0,0) == (y,U) as first element in your arrays
   % before integration with trapz command.
 
 figure(2),clf
 subplot(131)
 plot(Umean/Uf, y/delta_1 ,'o')
 hold on
 plot(fp,eta/1.7208,'k-','LineWidth',2)
 subplot(132)
 plot(A_TS/max(A_TS),y/delta_1,'o')
 hold on
 plot(uBI/max(uBI),eta_BI/1.7208,'k-','LineWidth',2)
 ylim([0 10])
 subplot(133)
 plot(phase,y/delta_1,'ro')
 
 %% generate Figure 3 - velocity profiles at Branch 2

 
% Use 'U6_XBII_velocity.txt' file for branch 1
% here y-vector (mm) ==> 3rd column
% Umean (m/s) ==> 5th column
% A_TS (m/s) ==> 7th column (TS wave amlitude)
% phase (degrees) ==>  8th column

% Repeat the whole procedure same as branch 1 for branch 2 and make a similar plot.
 
 %% generate Figure 4 - phase distribution vs X
 
% Use 'U6_phase.txt' 
% X (mm) ==> column 2 
% phase (degrees) ==> column 8
 
 
 figure(4),clf
 plot(X,phase,'ro-')   %% will generate a saw-tooth function like plot.
 
 
 phase=unwrap(deg2rad(phase));   % removes the phase-shift in X 
 
 figure(5),clf
 plot(X,phase,'ro-')   %% will generate a straight-line plot.
 
 % fit a straight line to phase & X to get the slope dphi/dx and compute
 % alpha_r , Lambda_TS , c_TS experimentally.
 