clear all
clc

%Starting Coordinates (Degrees, N=+, E=+)
%SAN FRANCISCO, CA
initlat = 37.7749;
initlong = -122.4194;
%Final Destination
%OAKLAND, CA
finlat = 37.8044;
finlong = -122.2712;

%Trim Velocity components
initu = 226.333;%226.334
initv = 0;
initw = -6.5;

%Initial rates
initp=0;
initq=0;
initr=0;

%Initial attitude
initbank = 0;
initpitch=initw/initu;%0.0262;
inithead=0;

%Initial Position
initnorth=0;
initeast=0;
initalt=5000;

% NAVION stability derivatives

% CL
cla=4.44;
cladot=0;
clq=3.8;
clde=0.355;
clo=0.41;

% CD
cda2=0.33;
cdo=0.05;

% CM
cma=-0.683;
cmde=-0.923;
cmadot=-4.36;
cmq=-9.96;

%CY
cyb = -0.564;
cydr = 0.157;

%CL - Roll
clb = -0.074;
clp = -0.410;
clr = 0.107;
clda = -0.134;
cldr = 0.107;

%CN
cnb = 0.071;% needs to be positive
cnp = -0.0575;
cnr = -0.125;
cnda = -0.0035;
cndr = -0.072;

sw=184;
b=33.4;
cbar = 5.7;
weight = 2750;

cg=[0 0 0];

ac=[0 0 0];

eng=[0 0 0];

jx= 1048;
jy=3000;
jz =3500;
jxz=0;

% Controls

elevator = 1.11*3.141/180; % Negative nose up 
aileron = 0;
rudder = 0;
throtle = 1;

control = [elevator, aileron, rudder, throtle];

bankrange = linspace(-pi,pi,100);

WP1 = [10000 10000 5000];
WP2 = [-10000 0 5500];
WP3 = [0 -10000 4500];


%Lookup tables --------------------------------------------------------
%Maximum angles in degree
Bank_Max_deg = 30;
Roll_Max_deg = 60;

%Max angles in radians
Bank_Max_rad= Bank_Max_deg * pi()/180;
Roll_Max_rad = Roll_Max_deg * pi()/180;

%Denominators
Bank_Slope_den = 1;
Roll_Slope_den = 1;

%For loop for data points
points = (-180:180)*(pi()/180);

RB_Bank = zeros(1,length(points));
Bank_rate = zeros(1,length(points));
for i = 1:length(points)
    RB_Bank(i) = Bank_Max_rad * tanh(points(i)/Bank_Slope_den);
    Bank_rate(i) = Roll_Max_rad * tanh(points(i)/Roll_Slope_den);
end