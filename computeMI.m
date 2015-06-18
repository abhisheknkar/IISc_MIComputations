function MI = computeMI(Xrand,Yrand)

    Xrange = unique(Xrand);
    Yrange = unique(Yrand);
    sizeX = length(Xrange);
    sizeY = length(Yrange);

    nosXY = zeros(sizeX,sizeY);
    MIXY = zeros(sizeX,sizeY);
    nosX = zeros(sizeX,1);
    nosY = zeros(sizeY,1);

    for i = 1:sizeX
        nosX(i) = length(find(Xrand==Xrange(i)));
    end

    for i = 1:sizeY
        nosY(i) = length(find(Yrand==Yrange(i)));        
    end

    for i = 1:sizeX
        for j = 1:sizeY
            nosXY(i,j) = length(intersect(find(Xrand==Xrange(i)),find(Yrand==Yrange(j))));
            MIXY(i,j) = nosXY(i,j)/nosX(i)/nosY(j);
        end
    end

    MI = sum(sum(MIXY));
end