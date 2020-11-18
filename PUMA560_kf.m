%% forward
% get T
syms theta theta1 theta2 theta3 theta4 theta5 theta6 alpha d a 
%{
A_degree = [cosd(theta),-sind(theta)*cosd(alpha),sind(theta)*sind(alpha),a*cosd(theta);
    sind(theta),cosd(theta)*cosd(alpha),-cosd(theta)*sind(alpha),a*sind(theta);
    0          ,sind(alpha) , cosd(alpha),d;
    0,0,0,1]
%}
% type the transfer function of an axis
A_rad = [   cos(theta)  ,-sin(theta)*cos(alpha) ,sin(theta)*sin(alpha)  ,a*cos(theta)   ;
            sin(theta)  ,cos(theta)*cos(alpha)  ,-cos(theta)*sin(alpha) ,a*sin(theta)   ;
            0           ,sin(alpha)             , cos(alpha)            ,d              ;
            0           ,0                      ,0                      ,1]             ;

A(:,:,1) = vpa(subs(A_rad,[theta,alpha,a,d],[theta1,-90*pi/180,0    ,0    ]));
A(:,:,2) = vpa(subs(A_rad,[theta,alpha,a,d],[theta2,0         ,0.432,0    ]));
A(:,:,3) = vpa(subs(A_rad,[theta,alpha,a,d],[theta3,90*pi/180        ,-0.02,0.149]));
A(:,:,4) = vpa(subs(A_rad,[theta,alpha,a,d],[theta4,-90*pi/180       ,0    ,0.433]));
A(:,:,5) = vpa(subs(A_rad,[theta,alpha,a,d],[theta5,90*pi/180        ,0    ,0    ]));
A(:,:,6) = vpa(subs(A_rad,[theta,alpha,a,d],[theta6,0         ,0    ,0    ]));
T6 = 1;

for i = 1:6
    T6 = T6 * A(:,:,i);
    disp(A(:,:,i));
end
disp(simplify(T));
%disp(simplify(T))
%get x,y,z,phi,theta,psi
x = simplify(T(1,4))
y = simplify(T(2,4))
z = simplify(T(3,4))
%calculate phi
phi = simplify(atan2d(T6(2,3),T6(1,3)))
%calculate theta
THy = T6(1,3)*cos(pi/180*phi) + T6(2,3)*sin(pi/180*phi);
THx = T6(3,3);

theta = simplify(atan2d(THy,THx))
%calculate psi
psiy = -T6(1,1)*sin(pi/180*phi) + T6(2,1)*cos(pi/180*phi);
psix = -T6(1,2)*sin(pi/180*phi) + T6(2,2)*cos(pi/180*phi);

psi = simplify(atan2d(psiy,psix))
%input output

for i = 1:6
    angle(i) =  input('angle?')
end
x = vpa(subs(x,[theta1,theta2,theta3,theta4,theta5,theta6],[angle]));
y = vpa(subs(y,[theta1,theta2,theta3,theta4,theta5,theta6],[angle]));
z = vpa(subs(z,[theta1,theta2,theta3,theta4,theta5,theta6],[angle]));
phi = vpa(subs(phi,[theta1,theta2,theta3,theta4,theta5,theta6],[angle(1),angle(2),angle(3),angle(4),angle(5),angle(6)]));
theta= vpa(subs(theta,[theta1,theta2,theta3,theta4,theta5,theta6],[angle]));
psi = vpa(subs(psi,[theta1,theta2,theta3,theta4,theta5,theta6],[angle]));
fprintf('x         y         z         phi         theta         phi\n');
fprintf('%f  %f  %f %f %f %f\n',x,y,z,phi,theta,psi);
%% inverse