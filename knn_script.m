%Change k (this code only works for k = 3,4, or 5). The will be a
%coresponding knn function...knn(vector, comparison vector set,k)
k = 3;



%import data.
Data = struct;
Data.trainning = load('optdigitstrainning.csv');
len = length(Data.trainning);

Data.test = load('optdigitstestting.csv');

len=length(Data.trainning);
col=Data.trainning(:,65);
row=col';


% Knn calculation

v = zeros(2,length(Data.test))';
v(:,1) = Data.test(:,65);
v(:,2) = zeros(1,length(Data.test))';


for i = 1:length(Data.test)
    v(i,2) = knn(Data.test(i,1:65),Data.trainning,k);
end

counter = 0;
for i=1:length(Data.test)
    if v(i,1)== v(i,2)
        counter = counter + 1;
    end
end
accuracy  = counter/length(Data.test);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Laplacian Not working
%{
%Building the laplacian matrix.

%Matrix of all distances to find out sigma.
len = length(Data.test);
A_d = zeros(len,len);
for i=1:len
    
    for j=1:length(Data.test)
        if i~=j
        A_d(i,j) =euclid(Data.test(i,:),Data.test(j,:));
        end
    end
end


A = zeros(len,len);
for i = 1:len
    for j = 1:len
        if i~=j
            if v(i,2) == v(j,2)
                A(i,j) = 1;
            end
        end
    end
end

d = zeros(len,1);
for i = 1:len
    d(i,1) = sum(A(i,:));
end

D = diag(d);

L = D - A;
[eigen_vector, eigen_value] = eig(L);
M = eigen_vector(:,2:4);
scatter3(M(:,1),M(:,2),M(:,3),100, v(:,2), 'filled');
%}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% k = 3: 0.978853644963829
% k = 4: 0.981636060100167
% k = 5: 0.978853644963829