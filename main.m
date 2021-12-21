close all; clear;
addpath('./Component');
data1 = load('data1.mat');
data2 = load('data2.mat');
color = [1 1 0; 1 0 1; 0 1 1; 1 0 0; 0 1 0; 0 0 1; 0.7 0.3 0.3; 0 0 0];

data_test_1 = data1.X;
data_test_2 = data2.X;

%%
%%K means
data1 = reshape(data_test_1(1,:), [700,1]);
data1 = [data1 reshape(data_test_1(2, :), [700,1])];

data2 = reshape(data_test_2(1,:), [1400,1]);
data2 = [data2 reshape(data_test_2(2, :), [1400,1])];
%%
[idx_data_1, C_data1] = kmeans(data1, 2);
[idx_data_2, C_data2] = kmeans(data2, 2);
Cost_2means_data1 = cost_function(data1, idx_data_1)
Cost_2means_data2 = cost_function(data2, idx_data_2)
%%plot figure
figure();
gscatter(data1(:,1),data1(:,2),idx_data_1, 'bg')
hold on
plot(C_data1(:,1),C_data1(:,2),'kx')
%legend('Cluster 1','Cluster 2','Cluster Centroid')
title('K means data1 K=2')

figure();
gscatter(data2(:,1),data2(:,2),idx_data_2, 'bg')
hold on
plot(C_data2(:,1),C_data2(:,2),'kx')
%legend('Cluster 1','Cluster 2','Cluster Centroid')
title('K means data2 K=2')

[idx_data_1, C_data1] = kmeans(data1, 4);
[idx_data_2, C_data2] = kmeans(data2, 4);
Cost_4means_data1 = cost_function(data1, idx_data_1)
Cost_4means_data2 = cost_function(data2, idx_data_2)
%%plot figure
figure();
gscatter(data1(:,1),data1(:,2),idx_data_1, color)
hold on
plot(C_data1(:,1),C_data1(:,2),'kx')
%legend('Cluster 1','Cluster 2','Cluster Centroid')
title('K means data1 K=4')

figure();
gscatter(data2(:,1),data2(:,2),idx_data_2, color)
hold on
plot(C_data2(:,1),C_data2(:,2),'kx')
%legend('Cluster 1','Cluster 2','Cluster Centroid')
title('K means data2 K=4')

[idx_data_1, C_data1] = kmeans(data1, 8);
[idx_data_2, C_data2] = kmeans(data2, 8);
Cost_8means_data1 = cost_function(data1, idx_data_1)
Cost_8means_data2 = cost_function(data2, idx_data_2)

%%plot figure
figure();
gscatter(data1(:,1),data1(:,2),idx_data_1, color)
hold on
plot(C_data1(:,1),C_data1(:,2),'kx')
%legend('Cluster 1','Cluster 2','Cluster Centroid')
title('K means data1 K=8')

figure();
gscatter(data2(:,1),data2(:,2),idx_data_2, color)
hold on
plot(C_data2(:,1),C_data2(:,2),'kx')
%legend('Cluster 1','Cluster 2','Cluster Centroid')
title('K means data2 K=8')



%%
%%Spectral Clustering
data1_layer1_classify = spectral_cluster(data1);
Y = data1_layer1_classify;

Cost_2spec_cluster_data1 = cost_function(data1, Y)

figure();
gscatter(data1(:,1),data1(:,2), data1_layer1_classify, 'bg')
title('Spectral Clustering for Data1 2 classes')


%%seperate the two clustered data
flag1 = 1;
flag2 = 1;
for i = 1:length(data1)
    if data1_layer1_classify(i) == 1
        cluster_layer2_data1_1(flag1,:) = data1(i,:);
        flag1 = flag1+1;
    else
        cluster_layer2_data1_2(flag2,:) = data1(i,:);
        flag2 = flag2+1;
    end
end

data1_layer2_classify_1 = spectral_cluster(cluster_layer2_data1_1);
data1_layer2_classify_2 = spectral_cluster(cluster_layer2_data1_2);

flag1=1;
flag2=1;
for i = 1:length(data1)
    if Y(i, 1) == 1
        Y(i, 2) = data1_layer2_classify_1(flag1);
        flag1 = flag1+1;
    else 
        Y(i, 2) = data1_layer2_classify_2(flag2);
        flag2 = flag2+1;
    end
end

flag1 = 1; flag2 = 1; flag3 = 1; flag4 = 1;
position = 1;
for i = 1:length(data1)
    if Y(i, 1) == 1 && Y(i,2) == 1
        cluster_layer3_data1_1(flag1,:) = data1(i,:);
        z(position,1) = 1;
        flag1 = flag1+1;
    elseif Y(i, 1) == 1 && Y(i,2) == 2
        cluster_layer3_data1_2(flag2,:) = data1(i,:);
        z(position,1) = 2;
        flag2 = flag2+1;
    elseif Y(i, 1) == 2 && Y(i,2) == 1
        cluster_layer3_data1_3(flag3,:) = data1(i,:);
        z(position,1) = 3;
        flag3 = flag3+1;
    else
        cluster_layer3_data1_4(flag4,:) = data1(i,:);
        z(position,1) = 4;
        flag4 = flag4+1;
    end
    position = position+1;
end

Cost_4spec_cluster_data1 = cost_function(data1, z)
figure();
gscatter(data1(:,1),data1(:,2), z, 'rgbk')
title('Spectral Clustering for Data1 4 classes')

data1_layer3_classify_1 = spectral_cluster(cluster_layer3_data1_1);
data1_layer3_classify_2 = spectral_cluster(cluster_layer3_data1_2);
data1_layer3_classify_3 = spectral_cluster(cluster_layer3_data1_3);
data1_layer3_classify_4 = spectral_cluster(cluster_layer3_data1_4);

flag1=1; flag2=1; flag3=1; flag4=1;
for i = 1:length(data1)
    if Y(i, 1) == 1 && Y(i, 2) == 1
        Y(i, 3) = data1_layer3_classify_1(flag1);
        flag1 = flag1+1;
    elseif Y(i, 1) == 1 && Y(i, 2) == 2
        Y(i, 3) = data1_layer3_classify_2(flag2);
        flag2 = flag2+1;
    elseif Y(i, 1) == 2 && Y(i, 2) == 1
        Y(i, 3) = data1_layer3_classify_3(flag3);
        flag3 = flag3+1;
    else
        Y(i, 3) = data1_layer3_classify_4(flag4);
        flag4 = flag4+1;
    end
end

for i = 1:length(data1)
    if Y(i, 1) == 1 && Y(i, 2) == 1 && Y(i, 3) == 1
        Y(i, 4) = 1;
    elseif Y(i, 1) == 1 && Y(i, 2) == 1 && Y(i, 3) == 2
        Y(i, 4) = 2;
    elseif Y(i, 1) == 1 && Y(i, 2) == 2 && Y(i, 3) == 1
        Y(i, 4) = 3;
    elseif Y(i, 1) == 1 && Y(i, 2) == 2 && Y(i, 3) == 2
        Y(i, 4) = 4;
    elseif Y(i, 1) == 2 && Y(i, 2) == 1 && Y(i, 3) == 1
        Y(i, 4) = 5;
    elseif Y(i, 1) == 2 && Y(i, 2) == 1 && Y(i, 3) == 2
        Y(i, 4) = 6;
    elseif Y(i, 1) == 2 && Y(i, 2) == 2 && Y(i, 3) == 1
        Y(i, 4) = 7;
    else
        Y(i, 4) = 8;
    end

end

Cost_8spec_cluster_data1 = cost_function(data1, Y(:,4))


figure();
gscatter(data1(:,1),data1(:,2), Y(:,4), color)
title('Spectral Clustering for Data1 (8 Classes)')

%%
%%spectral cluster data2

%%Spectral Clustering
data2_layer1_classify = spectral_cluster(data2);
Y = data2_layer1_classify;

Cost_2spec_cluster_data2 = cost_function(data2, Y)
figure();
gscatter(data2(:,1),data2(:,2), Y, 'bg')
title('Spectral Clustering for Data2 2 classes')

flag1 = 1;
flag2 = 1;
for i = 1:length(data2)
    if data2_layer1_classify(i) == 1
        cluster_layer2_data2_1(flag1,:) = data2(i,:);
        flag1 = flag1+1;
    else
        cluster_layer2_data2_2(flag2,:) = data2(i,:);
        flag2 = flag2+1;
    end
end

data2_layer2_classify_1 = spectral_cluster(cluster_layer2_data2_1);
data2_layer2_classify_2 = spectral_cluster(cluster_layer2_data2_2);

flag1=1;
flag2=1;
for i = 1:length(data2)
    if Y(i, 1) == 1
        Y(i, 2) = data2_layer2_classify_1(flag1);
        flag1 = flag1+1;
    else 
        Y(i, 2) = data2_layer2_classify_2(flag2);
        flag2 = flag2+1;
    end
end

flag1 = 1; flag2 = 1; flag3 = 1; flag4 = 1;
position = 1;
for i = 1:length(data2)
    if Y(i, 1) == 1 && Y(i, 2) == 1
        cluster_layer3_data2_1(flag1,:) = data2(i,:);
        z(position,1) = 1;
        flag1 = flag1+1;
    elseif Y(i, 1) == 1 && Y(i,2) == 2
        cluster_layer3_data2_2(flag2,:) = data2(i,:);
        z(position,1) = 2;
        flag2 = flag2+1;
    elseif Y(i, 1) == 2 && Y(i,2) == 1
        cluster_layer3_data2_3(flag3,:) = data2(i,:);
        z(position,1) = 3;
        flag3 = flag3+1;
    else
        cluster_layer3_data2_4(flag4,:) = data2(i,:);
        z(position,1) = 4;
        flag4 = flag4+1;
    end
    position = position + 1;
end


Cost_4spec_cluster_data2 = cost_function(data2, z)
figure();
gscatter(data2(:,1),data2(:,2), z, 'rgbk')
title('Spectral Clustering for Data2 4 classes')

data2_layer3_classify_1 = spectral_cluster(cluster_layer3_data2_1);
data2_layer3_classify_2 = spectral_cluster(cluster_layer3_data2_2);
data2_layer3_classify_3 = spectral_cluster(cluster_layer3_data2_3);
data2_layer3_classify_4 = spectral_cluster(cluster_layer3_data2_4);

flag1=1; flag2=1; flag3=1; flag4=1;
for i = 1:length(data2)
    if Y(i, 1) == 1 && Y(i, 2) == 1
        Y(i, 3) = data2_layer3_classify_1(flag1);
        flag1 = flag1+1;
    elseif Y(i, 1) == 1 && Y(i, 2) == 2
        Y(i, 3) = data2_layer3_classify_2(flag2);
        flag2 = flag2+1;
    elseif Y(i, 1) == 2 && Y(i, 2) == 1
        Y(i, 3) = data2_layer3_classify_3(flag3);
        flag3 = flag3+1;
    else
        Y(i, 3) = data2_layer3_classify_4(flag4);
        flag4 = flag4+1;
    end
end

for i = 1:length(data2)
    if Y(i, 1) == 1 && Y(i, 2) == 1 && Y(i, 3) == 1
        Y(i, 4) = 1;
    elseif Y(i, 1) == 1 && Y(i, 2) == 1 && Y(i, 3) == 2
        Y(i, 4) = 2;
    elseif Y(i, 1) == 1 && Y(i, 2) == 2 && Y(i, 3) == 1
        Y(i, 4) = 3;
    elseif Y(i, 1) == 1 && Y(i, 2) == 2 && Y(i, 3) == 2
        Y(i, 4) = 4;
    elseif Y(i, 1) == 2 && Y(i, 2) == 1 && Y(i, 3) == 1
        Y(i, 4) = 5;
    elseif Y(i, 1) == 2 && Y(i, 2) == 1 && Y(i, 3) == 2
        Y(i, 4) = 6;
    elseif Y(i, 1) == 2 && Y(i, 2) == 2 && Y(i, 3) == 1
        Y(i, 4) = 7;
    else
        Y(i, 4) = 8;
    end

end

figure();
gscatter(data2(:,1),data2(:,2), Y(:,4), color)
title('Spectral Clustering for Data2 (8 Classes)')

Cost_8spec_cluster_data2 = cost_function(data2,Y(:,4))








