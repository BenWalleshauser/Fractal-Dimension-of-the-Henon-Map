% Ben Walleshauser

%Estimating the fractal dimension of the Henon Map w/. box counting
%% Finding a Solution for the Map
close all
clc
clear

Final = 50000;
x = zeros(Final,1);
y = zeros(Final,1);
x(1) = 0;
y(1) = 0;

a = 1.4;
b = 0.30;

%Finding a solution for the Henon Map
for i = 1:Final
    x(i+1) = 1 - a*x(i)^2+y(i);
    y(i+1) = b*x(i);
end

figure(1)
hold on
grid on
plot(x,y,'.') 
xlabel('x')
ylabel('y')
title('Henon Map')
hold off

%% Box Counting

%Different bin sizes
eps = 1./(2.^[3:8]');

%Number of boxes that have an instance of the solution 
HitBoxes = zeros(length(eps),1);

%Total number of boxes for the given bin size (not necessary)
TotalBoxes = zeros(length(eps),1);

%Going to vary the bin size (eps) and see how many boxes are covered/hit
%by the solution
for i = 1:length(eps)
    [P,C] = hist3([x y],'edges',{-2:eps(i):2-eps(i) -2:eps(i):2-eps(i)});   
    HitBoxes(i) = length(nonzeros(P));
    TotalBoxes(i) = numel(P);   
end

%% Finding Slope

%Box-counting dimension is the slope of the resulting regression
p = polyfit(log2(1./eps),log2(HitBoxes),1);
BoxDim = p(1)

%% Visuals

figure(2)
hold on
grid on
title('Finding the Box Counting Dimension')
plot(log2(1./eps),log2(HitBoxes))
xlabel('log2(1/eps)')
ylabel('log2(N(eps))')
hold off

