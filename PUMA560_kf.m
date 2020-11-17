%% forward
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

A1 = vpa(subs(A_rad,[theta,alpha,a,d],[theta1,-90*pi/180,0    ,0    ]));
A2 = vpa(subs(A_rad,[theta,alpha,a,d],[theta2,0         ,0.432,0    ]));
A3 = vpa(subs(A_rad,[theta,alpha,a,d],[theta3,90*pi/180        ,-0.02,0.149]));
A4 = vpa(subs(A_rad,[theta,alpha,a,d],[theta4,-90*pi/180       ,0    ,0.433]));
A5 = vpa(subs(A_rad,[theta,alpha,a,d],[theta5,90*pi/180        ,0    ,0    ]));
A6 = vpa(subs(A_rad,[theta,alpha,a,d],[theta6,0         ,0    ,0    ]));
T = A1*A2*A3*A4*A5*A6;

disp("A1 to A6")
disp(A1)
disp(A2)
disp(A3)
disp(A4)
disp(A5)
disp(A6)
disp(simplify(T))

%% inverse