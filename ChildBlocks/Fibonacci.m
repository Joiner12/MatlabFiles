%% Fibonacci
clear;
% handle data 
Fn = zeros(0);

for i = 1:1:100
    if i<=2
        Fn(i) = i - 1;
    else
        Fn(i) = Fn(i-1) + Fn(i-2);
    end
end

figure
p = plot(Fn,Fn,'*');
p.Color = 'r';


%% 
x = 0;
y = 1;
syms v u

axis off
hold on

for n = 1:10

    a = fibonacci(n);

    % Define squares and arcs
    switch mod(n,4)
        case 0
            y = y - fibonacci(n-2);
            x = x - a;
            eqnArc = (u-(x+a))^2 + (v-y)^2 == a^2;
        case 1
            y = y - a;
            eqnArc = (u-(x+a))^2 + (v-(y+a))^2 == a^2;
        case 2
            x = x + fibonacci(n-1);
            eqnArc = (u-x)^2 + (v-(y+a))^2 == a^2;
        case 3
            x = x - fibonacci(n-2);
            y = y + fibonacci(n-1);
            eqnArc = (u-x)^2 + (v-y)^2 == a^2;
    end

    % Draw square
    pos = [x y a a];
    rectangle('Position', pos)

    % Add Fibonacci number
    xText = (x+x+a)/2;
    yText = (y+y+a)/2;
    text(xText, yText, num2str(a))

    % Draw arc
    interval = [x x+a y y+a];
    fimplicit(eqnArc, interval, 'b')
end