function [U1,centroids_new] = partition_matrix( U,cluster,data_pts,m )
%partition_matrix - updates the partition matrix and centroid values

k=size(data_pts);
distance_matrix=zeros(cluster,k(1));
U1=zeros(cluster,k(1));
centroids_new=[;];
same_centroid=[;];

%Calculating the centroids on the basis of given partition matrix
u_m=U.^m;
centroids_new=u_m*data_pts;
for i=1:cluster
    sum1=sum(u_m(i,:),2);
    centroids_new(i,:)=centroids_new(i,:)./sum1;
end

%Calculating distance matrix
for i=1:cluster
    for j=1:k(1)
        distance_matrix(i,j)=pdist([centroids_new(i,:); data_pts(j,:)],'euclidean');
        if distance_matrix(i,j)==0
            same_centroid=[same_centroid;[i j]];
        end
    end
end

%Calculating Reciprocal of distance matrix 
rev_distmx=1./distance_matrix;
k1=size(same_centroid);
for i=1:k1(1)
    k2=same_centroid(i,:);
    rev_distmx(k2(1),k2(2))=0;
end

%Calculating partition matrix
rev_dmsq=rev_distmx.^(2/(m-1));
for j=1:k(1)
    sum2=sum(rev_dmsq(:,j),1);
    
    for i=1:cluster
        U1(i,j)=rev_dmsq(i,j)/sum2;
    end
end

for i=1:k1(1)
    k2=same_centroid(i,:);
    U1(k2(1),k2(2))=1;
    for j=1:cluster
        if j~=k2(2)
            U1(k2(1),j)=0;
        end
    end
end

end
