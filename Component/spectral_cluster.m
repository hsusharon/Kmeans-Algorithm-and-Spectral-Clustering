function class = spectral_cluster(data)
    for i = 1:length(data)
        for j = 1:length(data)
            if i~=j
                W(i,j) = exp((-1/10)* norm(data(i,:)-data(j,:))^2);
            else
                W(i,j)=0;
            end
        end
    end
    Sum_weight = sum(W);

    for i = 1:length(data)
        for j = 1:length(data)
            if i==j
                D(i,j) = Sum_weight(i);
            else
                D(i,j) = 0;
            end
        end
    end
    
    %D = D + 0.2 * eye(length(data));


    M = (D^(-1/2)) * (D-W) * (D^(-1/2));
    [V, E] = eig(M);
    [B, I] = sort(sum(E));

    z_vector = V(:,I(2));
    Y = (D^(-1/2)) * z_vector;
    for i = 1:length(Y)
        if Y(i)> 0
            Y(i) = 1;
        else
            Y(i) = 2;
        end
    end

    class = Y;

end