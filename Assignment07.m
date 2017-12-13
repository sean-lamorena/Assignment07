clear all; close all; clc;

I1 = imread('base.jpg');
I2 = imread('sub.jpg');
Ipts1 = OpenSurf(I1);
Ipts2 = OpenSurf(I2);

for k = 1:length(Ipts1)
    D1(:,k) = Ipts1(k).descriptor;
end

for k = 1:length(Ipts2)
    D2(:,k) = Ipts2(k).descriptor;
end

BaseLength = length(Ipts1);
SubLength = length(Ipts2);

for i = 1:BaseLength
    subtract = ( repmat(D1(:,i),...
        [1 SubLength])- D2).^2;
    distance = sum(subtract);
    [SubValue(i) SubIndex(i)] = min(distance);
end

[value, index] = sort(SubValue);
index = index(1:100);

BaseIndex = index;
SubIndex = SubIndex(index);

Pos1 = [ [ Ipts1(BaseIndex).y]',...
    [Ipts1(BaseIndex).x]' ];

Pos2 = [ [ Ipts2(SubIndex).y]',...
    [Ipts2(SubIndex).x]'+size(I1,2)];

diffX = Pos2(:,2) - Pos1(:,2);
diffY = Pos2(:,1) - Pos1(:,1);

angles = atan2d( diffY,diffX );
angles = round(angles);
angle = mode(angles);

indexMode = find(angles>angle-1&angles<angle+1);

I = cat(2, I1,I2);
figure, imshow(I); hold on;

plot( [Pos1(indexMode,2) Pos2(indexMode,2)]',...
    [Pos1(indexMode,1) Pos2(indexMode,1)]',...
    's-',...
    'linewidth',2);
