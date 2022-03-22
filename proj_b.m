%import data
writings = importdata('optdigitstrainning.csv');

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