clear;
%%  DH-Model 

d3 = 0.149; d4 = 0.433; a2 = 0.432; a3 =-0.02;

%% input 
N = input('N = [nx ny nz]\n');
O = input('O = [ox oy oz]\n');
A = input('A = [ax ay az]\n');
P = input('P = [px py pz]\n');

% N = [ -0.895511  0.19122  0.401864  ];
% O = [  0.434206  0.5734     0.694724  ];
% A = [  -0.09759   0.7966   -0.5965 ];
% P = [  0.340682    0.63781    -0.38642 ];
% sol = [50 50 50 50 50 50 ]
%% n,o,a,p array 

nx = N(1);ny = N(2);nz = N(3);                
ox = O(1);oy = O(2);oz = O(3);              
ax = A(1);ay = A(2);az = A(3);             
px = P(1);py = P(2);pz = P(3);           
T6 = [nx ox ax px; ny oy ay py; nz oz az pz; 0 0 0 1];


%% solve theta 1

theta_1 = zeros(1,8);

for i = 1:8
    if i<= 4
    theta_1(i) = atan2d(py,px)-atan2d(d3,((px^2 + py^2 - d3^2)^0.5));
    else
    theta_1(i) = atan2d(py,px)-atan2d(d3,(-(px^2 + py^2 - d3^2)^0.5));
    end
end

%% solve theta 3 

M = (px^2 + py^2 + pz^2 -a2^2 - a3^2 -d3^2 -d4^2)/(2*a2);
theta_3 = zeros(1,8);
theta3_support = zeros(1,2);
theta3_support(1) = sqrt(a3^2+d4^2-M^2);
theta3_support(2) = -sqrt(a3^2+d4^2-M^2);

for i = 1:2
    for j =1:2
    theta_3(2*i-2+j) = atan2d(M,theta3_support(i))-atan2d(a3,d4);
    theta_3(2*i+2+j) = atan2d(M,theta3_support(i))-atan2d(a3,d4);
    end
end

%% solve theta 2

theta_2 = zeros(1,8);
for i = 1:8
       m1 = px*cosd(theta_1(i)) + py*sind(theta_1(i));
       m2 = pz;
       z1 = a3 + a2*cosd(theta_3(i));
       z2 = d4 + a2*sind(theta_3(i));
       x = (z1*m1 + z2*m2)/(m1^2 + m2^2);
       y = (z2*m1 - z1*m2)/(m1^2 + m2^2);
       theta_2(i) = atan2d(y,x) - theta_3(i);
end

%% solve theta 4 
theta_4 = zeros(1,8);
for i = 1:2:7
        c1 = cosd(theta_1(i));
        s1 = sind(theta_1(i));
        c2 = cosd(theta_2(i));
        s2 = sind(theta_2(i));
        c3 = cosd(theta_3(i));
        s3 = sind(theta_3(i));
        A1 = [c1 0 -s1 0; s1 0 c1 0; 0 -1 0 0; 0 0 0 1];
        A2 = [c2 -s2 0 a2*c2; s2 c2 0 a2*s2; 0 0 1 0; 0 0 0 1];
        A3 = [c3 0 s3 a3*c3; s3 0 -c3 a3*s3; 0 1 0 d3; 0 0 0 1];
        T36 = inv(A3)*inv(A2)*inv(A1)*T6;
        theta_4(i) = atan2d(T36(2,3),T36(1,3));
end
for i = 2:2:8
        c1 = cosd(theta_1(i));
        s1 = sind(theta_1(i));
        c2 = cosd(theta_2(i));
        s2 = sind(theta_2(i));
        c3 = cosd(theta_3(i));
        s3 = sind(theta_3(i));
        A1 = [c1 0 -s1 0; s1 0 c1 0; 0 -1 0 0; 0 0 0 1];
        A2 = [c2 -s2 0 a2*c2; s2 c2 0 a2*s2; 0 0 1 0; 0 0 0 1];
        A3 = [c3 0 s3 a3*c3; s3 0 -c3 a3*s3; 0 1 0 d3; 0 0 0 1];
        T36 = inv(A3)*inv(A2)*inv(A1)*T6;
        theta_4(i) = atan2d(-T36(2,3),-T36(1,3));
end

%% solve theta 5 

theta_5 = zeros(1,8);
for i = 1:8
        c1 = cosd(theta_1(i));
        s1 = sind(theta_1(i));
        c2 = cosd(theta_2(i));
        s2 = sind(theta_2(i));
        c3 = cosd(theta_3(i));
        s3 = sind(theta_3(i));
        c4 = cosd(theta_4(i));
        s4 = sind(theta_4(i));
        A1 = [c1 0 -s1 0; s1 0 c1 0; 0 -1 0 0; 0 0 0 1];
        A2 = [c2 -s2 0 a2*c2; s2 c2 0 a2*s2; 0 0 1 0; 0 0 0 1];
        A3 = [c3 0 s3 a3*c3; s3 0 -c3 a3*s3; 0 1 0 d3; 0 0 0 1];
        A4 = [c4 0 -s4 0; s4 0 c4 0; 0 -1 0 d4; 0 0 0 1];
        T46 = inv(A4)*inv(A3)*inv(A2)*inv(A1)*T6;
        theta_5(i) = 180/pi*atan2(T46(1,3),-T46(2,3));
end

%% solve theta 6 
theta_6 = zeros(1,8);
for i = 1:8
        c1 = cosd(theta_1(i));
        s1 = sind(theta_1(i));
        c2 = cosd(theta_2(i));
        s2 = sind(theta_2(i));
        c3 = cosd(theta_3(i));
        s3 = sind(theta_3(i));
        A1 = [c1 0 -s1 0; s1 0 c1 0; 0 -1 0 0; 0 0 0 1];
        A2 = [c2 -s2 0 a2*c2; s2 c2 0 a2*s2; 0 0 1 0; 0 0 0 1];
        A3 = [c3 0 s3 a3*c3; s3 0 -c3 a3*s3; 0 1 0 d3; 0 0 0 1];
        T36 = inv(A3)*inv(A2)*inv(A1)*T6;
        theta_6(i) = atan2d(T36(3,2)/theta_5(i),-T36(3,1)/theta_5(i));
end

%% OUTPUT

 fprintf('        theta1     theta2     theta3     theta4     theta5     theta6\n',i);
for i = 1:8
   fprintf('Set %d \n',i);  
    if theta_1(i) > 160 || theta_1(i)<-160
      fprintf('theta 1 is out of range\n'); 
   end
   
   if theta_2(i) > 125 || theta_2(i) < -125
      fprintf('theta 2 is out of range\n'); 
   end
   
   if theta_3(i) > 135 || theta_3(i) < -135
      fprintf('theta 3 is out of range\n'); 
   end
   
   if theta_4(i) > 140 || theta_4(i) < -140
      fprintf('theta 4 is out of range\n'); 
   end
  
   if theta_5(i) > 100 || theta_5(i) < -100
      fprintf('theta 5 is out of range\n'); 
   end
   if theta_6(i) > 260 || theta_6(i) < -260
      fprintf('theta 6 is out of range\n'); 
   end    
   fprintf('       %f   %f   %f   %f   %f   %f\n\n',theta_1(i), theta_2(i), theta_3(i), theta_4(i), theta_5(i), theta_6(i));
     fprintf('\n------------------------------------------------------------- \n');
end