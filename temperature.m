k=input("please input k--values");
disp(k)
t=0:0.1:5;
for i=1:length(k)
    T=temperatures(k(i),t);
    plot(t,T);
    hold on;
    grid on;
end
function [y] = temperatures(k,t)
y=exp(-k*t);
end