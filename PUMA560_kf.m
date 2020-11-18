%% forward
clear;
%%
%================================= DH-model =================================

syms theta theta1 theta2 theta3 theta4 theta5 theta6 alpha d a d3 d4 a2 a3

A_rad = [   cos(theta)  ,-sin(theta)*cos(alpha) ,sin(theta)*sin(alpha)  ,a*cos(theta)   ;
            sin(theta)  ,cos(theta)*cos(alpha)  ,-cos(theta)*sin(alpha) ,a*sin(theta)   ;
            0           ,sin(alpha)             , cos(alpha)            ,d              ;
            0           ,0                      ,0                      ,1]             ;
%%
%================================= Transfer function 1~6 =================================    

A(:,:,1) = vpa(subs(A_rad,[theta,alpha,a,d],[theta1,-90*pi/180  ,0      ,0    ]));
A(:,:,2) = vpa(subs(A_rad,[theta,alpha,a,d],[theta2,0           ,0.432  ,0    ]));
A(:,:,3) = vpa(subs(A_rad,[theta,alpha,a,d],[theta3,90*pi/180   ,-0.02  ,0.149]));
A(:,:,4) = vpa(subs(A_rad,[theta,alpha,a,d],[theta4,-90*pi/180  ,0      ,0.433]));
A(:,:,5) = vpa(subs(A_rad,[theta,alpha,a,d],[theta5,90*pi/180   ,0      ,0    ]));
A(:,:,6) = vpa(subs(A_rad,[theta,alpha,a,d],[theta6,0           ,0      ,0    ]));


%%
%================================= Transfer function T6 =================================
T6 = 1;

for i = 1:6
    T6 = T6 * A(:,:,i);
    %disp(A(:,:,i));
end
%disp(simplify(T6));

%%
%================================= get cartesian x y z =================================
%get x,y,z,phi,theta,psi
x = T6(1,4);
y = T6(2,4);
z = T6(3,4);

%%
%================================= get cartesian phi theta psi =================================
%calculate phi
phi = simplify(atan2d(T6(2,3),T6(1,3)));

%calculate theta
THy = T6(1,3)*cos(pi/180*phi) + T6(2,3)*sin(pi/180*phi);
THx = T6(3,3);

theta = simplify(atan2d(THy,THx));

%calculate psi
psiy = -T6(1,1)*sin(pi/180*phi) + T6(2,1)*cos(pi/180*phi);
psix = -T6(1,2)*sin(pi/180*phi) + T6(2,2)*cos(pi/180*phi);

psi = simplify(atan2d(psiy,psix));
%%
%================================= input =================================


angle = input('[theta1,theta2,theta3,theta4,theta5,theta6] : ')


angle = deg2rad(angle);

%%
%================================= output =================================
x = vpa(subs(x,[theta1,theta2,theta3,theta4,theta5,theta6],[angle]));
y = vpa(subs(y,[theta1,theta2,theta3,theta4,theta5,theta6],[angle]));
z = subs(z,[theta1,theta2,theta3,theta4,theta5,theta6],[angle]);
phi = vpa(subs(phi,[theta1,theta2,theta3,theta4,theta5,theta6],[angle(1),angle(2),angle(3),angle(4),angle(5),angle(6)]));
theta= vpa(subs(theta,[theta1,theta2,theta3,theta4,theta5,theta6],[angle]));
psi = vpa(subs(psi,[theta1,theta2,theta3,theta4,theta5,theta6],[angle]));

fprintf('(n,o,a,p)\n');
format short;disp(vpa(subs(T6,[theta1,theta2,theta3,theta4,theta5,theta6],[angle])));
format long;fprintf('Cartesian point\n(x,y,z,phi,theta,psi) = %f  %f  %f %f %f %f\n',x,y,z,phi,theta,psi);