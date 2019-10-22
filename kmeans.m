function [clusterMeans] = kmeans(D,k, epsilon)
%KMEANS Summary of this function goes here
%   Detailed explanation goes here

[rowD, colD] = size(D)
% column vector to store the information: 1, 2, or 3. 0 means unassigned
C=zeros(rowD, 1)
distanceFromMeans=zeros(k,1)
% t: iteration counter
t = 0

% Generate k random points as initial cluster means
U = rand(k,2);
U(:,1) = max(D(:,1)) * U(:,1);
U(:,2) = max(D(:,2)) * U(:,2);
while true
    t = t+1
    for row=1:rowD
        % Calculate distance from all means
        for i=1:k
            distanceFromMeans(i,1)=(D(row,:)-U(i,:))*(D(row,:)-U(i,:))'
        end
%       distanceFromMeans = D(row,:) * U';
        [minDist, index] = min(distanceFromMeans);
        C(row,1) = index;                     
    end
    
    newU = []
    for i=1:k
        %calculate new U from updated Cluster
        newMean = mean(D(find(C==i),:))
        if sum(isnan(newMean)) ~= 0
            newMean = U(i,:)
        end
        newU = [newU; newMean];
        
    end
    
    sumOfSquaredErrors = sum(sum((newU-U).*(newU-U)))
    if t==10 || sumOfSquaredErrors <= epsilon
        disp("Stopping iteration")
        break
    end
    U = newU;    
end
% store the value of last mean in clusterMeans
clusterMeans = newU
end

