%Program to implement Fuzzy C-Means (FCM)
%Code by - Rishabh Srivastava
clc;
clear;

%Here, the data points are generated randomly
%Different data points can also be specified by slight modifications in the code
data_ptsx=randn(1,1000)+3;
data_ptsx=data_ptsx';
data_ptsy=randn(1,1000)+3;
data_ptsy=data_ptsy';
data_pts=[data_ptsx data_ptsy];
figure(1)
plot(data_ptsx',data_ptsy','o') %Plotting the data
title('Input Data Points')

disp('Input data processed ...')

% Specifications for FCM -> cluster size and fuzzifier parameter, m
cluster=4;
m=2;
disp('Cluster size and fuzzifier parameter specified ...')

%Randomly initializing the partition matrix
data_size = size(data_pts);
Ucols = data_size(1);
Urows = cluster;
U_old = zeros(Urows, Ucols);
for n=1:Ucols
    k = randi(Urows);
    U_old(k,n) = 1;
end
disp('Partition Matrix Initialised ...')
%Running FCM algorithm, updating partition matrix with each iteration
for n=1:10
    [U_new,centroids_new] = partition_matrix( U_old,cluster,data_pts,m );
    if abs(U_old-U_new)<0.01
        break
    end
    U_old=U_new;
       
end
disp('Data points clustered!')

% Plotting data points after clustering
figure(2)
hold on
for i=1:1000
    k=U_new(:,i);
    [a,b]=find(k==max(k));
    if a(1)==1
        plot(data_ptsx(i,1),data_ptsy(i,1),'o--r')
    elseif a(1)==2
        plot(data_ptsx(i,1),data_ptsy(i,1),'o--g')
    elseif a(1)==3
        plot(data_ptsx(i,1),data_ptsy(i,1),'o--c')
    elseif a(1)==4
        plot(data_ptsx(i,1),data_ptsy(i,1),'o--y')
       
    end
end

%Plottin the centroids of cluster
plot(centroids_new(:,1),centroids_new(:,2),'k*')
title('Data Points After Clustering Using FCM')
hold off