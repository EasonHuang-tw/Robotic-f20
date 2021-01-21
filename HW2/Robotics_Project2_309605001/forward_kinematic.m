function T6 = forward_kinematic(theta)
% clear all; close all;clc

%%  parameters
%theta1 = 30.0003/180*pi;
%theta2 = 29.4022/180*pi;
%theta3 = 29.9860/180*pi;
%theta4 = 70.6104/180*pi;
%theta5 = 49.9976/180*pi;
%theta6 = 19.9979/180*pi;

%theta1 = 30.0003/180*pi;
%theta2 = 59.9900/180*pi;
%theta3 = -29.9860/180*pi;
%theta4 = 99.9947/180*pi;
%theta5 = 49.9976/180*pi;
%theta6 = 19.9979/180*pi;

% theta1 = 14.9985/180*pi;
% theta2 = 90.0043/180*pi;
% theta3 = -50.0115/180*pi;
% theta4 = 20.0084/180*pi;
% theta5 = 49.9993/180*pi;
% theta6 = -59.9980/180*pi;

theta1 = theta(1)/180*pi;
theta2 = theta(2)/180*pi;
theta3 = theta(3)/180*pi;
theta4 = theta(4)/180*pi;
theta5 = theta(5)/180*pi;
theta6 = theta(6)/180*pi;


a2 = 43.2;
a3 = -2;
d3 = 14.9;
d4 = 43.3;

% Transformatiom matrix A1~A6
A1 = [ cos(theta1)              0   -sin(theta1)                 0;
       sin(theta1)              0    cos(theta1)                 0;
                 0             -1              0                 0;
                 0              0              0                 1  ];
             
A2 = [ cos(theta2)   -sin(theta2)              0    a2*cos(theta2);
       sin(theta2)    cos(theta2)              0    a2*sin(theta2);
                 0              0              1                 0;
                 0              0              0                 1  ];

A3 = [ cos(theta3)              0    sin(theta3)    a3*cos(theta3);
       sin(theta3)              0   -cos(theta3)    a3*sin(theta3);
                 0              1              0                d3;
                 0              0              0                 1  ];
             
A4 = [ cos(theta4)              0   -sin(theta4)                 0;
       sin(theta4)              0    cos(theta4)                 0;
                 0             -1              0                d4;
                 0              0              0                 1  ];
             
A5 = [ cos(theta5)              0    sin(theta5)                 0;
       sin(theta5)              0   -cos(theta5)                 0;
                 0              1              0                 0;
                 0              0              0                 1  ];
             
A6 = [ cos(theta6)   -sin(theta6)              0                 0;
       sin(theta6)    cos(theta6)              0                 0;
                 0              0              1                 0;
                 0              0              0                 1  ];


T6 = A1*A2*A3*A4*A5*A6;             
T3 = A1*A2*A3;

% Output (x,y,z,£r,£c,£p)
x = T6(1,4);
y = T6(2,4);
z = T6(3,4);

phi = atan2( T6(2,3) , T6(1,3) );
theta = atan2( cos(phi)*T6(1,3) + sin(phi)*T6(2,3) , T6(3,3) );
psi = atan2( -sin(phi)*T6(1,1) + cos(phi)*T6(2,1) , -sin(phi)*T6(1,2) + cos(phi)*T6(2,2) );


% disp('input:')
% fprintf('\n')
% disp('(£c1,£c1,£c3,£c4,£c5,£c6) =')
% fprintf('\n') 
% disp([theta1/pi*180 theta2/pi*180 theta3/pi*180 theta4/pi*180 theta5/pi*180 theta6/pi*180])
% disp('output:')
% fprintf('\n')
% disp('(n,o,a,p) =')
% disp(T6)
% disp('(x,y,z,£r,£c,£p) =')
% disp([T6(13) T6(14) T6(15 ) phi theta psi])