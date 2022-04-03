function knn = knn(u,data,x)
leng = length(data);
v(:,1) = [1:leng]'; v(:,2) = zeros(1,leng)'; v(:,3) = zeros(1,leng)';
v_x(:,1) = zeros(1,x)'; v_x(:,2) = zeros(1,x)'; v_x(:,3) = zeros(1,x)';
cluster = 11;


for k = 1:leng
    v(k,2) = data(k,65);
    v(k,3) = euclid(u(1,1:65),data(k,1:65));
end
v = sortrows(v,3,'ascend');
v_x(1:x,1) = v(1:x,1); v_x(1:x,2) = v(1:x,2); v_x(1:x,3) = v(1:x,3);
v_ux = unique(v_x(:,2)');

counts(:,1) = v_ux'; counts(:,2) = zeros(1,length(v_ux))';
for i = 1:length(v_ux)
    counts(i,2) = sum(v_x(:,2)'==v_ux(i));
end

counts = sortrows(counts, 2, 'descend');


if x == 3
    if counts(1,2) == 1
        cluster  = v_x(1,2);
    elseif counts(1,2) == 2 || counts(1,2) == 3
        cluster = counts(1);
    end
    
end


if x == 4 || x == 5
    
     
     if counts(1,2) == 2 && counts(2,2) == 2
        b_1 = 0;
        c_1 = 0;
        d_1 = 0;
        e = 0;
        f = 0;
        b_2 = 0;
        c_2 = 0;
        d_2 = 0;
        
        for i = 1:1
            for j = 1:length(v_x(:,2))
                if counts(i) == v_x(j,2)
                    b_1 = b_1+1;
                    
                    if b_1 == 1
                        c = v_x(j,3);
                    end
                    
                    if b_1 == 2
                        d = v_x(j,3);
                        e = sqrt((c^2+d^2)/2);
                        break
                    end
                    
                end
            end
        end
        
        for i = 2:2
            for j = 1:length(v_x(:,2))
                if counts(i) == v_x(j,2)
                    b_2 = b_2+1;
                    
                    if b_2 == 1
                        c_2 = v_x(j,3);
                    end
                    
                    if b_2 == 2
                        d_2 = v_x(j,3);
                        f = sqrt((c_2^2+d_2^2)/2);
                        break
                    end
                    
                end
            end
        end
        
        if e<f
            cluster = counts(1);
        else
            cluster = counts(2);
        end
        
     elseif counts(1,2) == 1
        cluster = v_x(1,2);
     else
        cluster = counts(1);
    end
end
knn = cluster;
end