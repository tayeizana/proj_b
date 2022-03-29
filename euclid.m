function euclid = euclid(x,y)
dist = zeros(1,64);
for i=1:64
    dist(i) = abs(x(1,i) - y(1,i))^2;
end
euclid = sqrt(sum(dist'));
end
