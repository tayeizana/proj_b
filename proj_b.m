%import data
writings = load('optdigitstrainning.csv');

%Convers each row of "writings" into an 8x8, and puts them in a cell "images".
images = cell(1,length(writings));
A = zeros(8,8);
for a=1:length(writings)
    for i = 0:7
         for j = 1:8
              A(i+1,j) = writings(a,(i*8)+j)*5;
         end
    end
    images{a} = A;
end
%{
a = cell(1,length(images));
for k = 1:length(images)
    
C = images{k};
D = zeros(8,8);
for i = 1:8
    for j = 1:8
        if C(i,j)>0
           D(i,j) = 1; 
        else
            D(i,j) = 0; 
        end
    end
end
a{k} = D;
end 
%}


%{
B = zeros(3823,2);
C = zeros(3823,2);
distance = struct;
for i = 1:length(writings)
    for k = 1:length(writings)
       dv_e = zeros(1,64);
       dv = zeros(1,64);
       for j = 1:64
           dv_e(1,j) = abs(writings(i,j) - writings(k,j))^2;
           dv(1,j) = abs(writings(i,j) - writings(k,j));
       end
       B(k,1) = k; B(k,2) = sqrt(sum(dv_e'));
       C(k,1) = k; C(k,2) = sum(dv');
       
    end
    distance.euclid{i} = B;
    distance.Manhattan{i} = C;
end
%}

%{
b = 1;
orvectors = struct;
for a = 0:9
    for i = b:length(wrorder)
        if wrorder(i,65) ~= a
            orvectors.data{a+1} = wrorder(b:i-1,:);
            b = i;
            break;
            
        end
    end
end
%}

len=length(writings);
col = writings(:,65);
row = col';
A = zeros(len, len);

for i=1:len
    
    for j=1:len
        if col(i) == row(1,j) 
            A(i,j) = 1;
        end
    end
    
end

A_w = zeros(len,len);

for i=1:len
    
    for j=1:len
        if i~=j
        A_w(i,j) = exp((-1*((euclid(writings(i,:),writings(j,:)))^2)));
        end
    end
end

d = zeros(len,1);
for i = 1:len
    d(i) = sum(A(:,i)');
end
D = diag(d);
L = D-A_w;

for i=1:len
    for j=1:len
        if L(i,j) < -1e-50
            L(i,j) = 0;
        end
    end
end

L_G = graph(L);
h = plot(L_G,'Layout','force');

