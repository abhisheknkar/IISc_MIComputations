function MI = computeMI(Xrand,Yrand)

    Xrange = unique(Xrand);
    Yrange = unique(Yrand);
    sizeX = length(Xrange);
    sizeY = length(Yrange);
    
    eps0 = 1e-7;
    
    MIXY = zeros(sizeX,sizeY);  

    nosXY = zeros(sizeX,sizeY);
    nosX = zeros(sizeX,1);
    nosY = zeros(sizeY,1);

    PXY = zeros(sizeX,sizeY);
    PX = zeros(sizeX,1);
    PY = zeros(sizeY,1);

    for i = 1:sizeX
        nosX(i) = length(find(Xrand==Xrange(i)));
        PX(i) = nosX(i)/length(Xrand);
    end

    for i = 1:sizeY
        nosY(i) = length(find(Yrand==Yrange(i)));        
        PY(i) = nosY(i)/length(Yrand);
    end

    for i = 1:sizeX
        for j = 1:sizeY
            nosXY(i,j) = length(intersect(find(Xrand==Xrange(i)),find(Yrand==Yrange(j))));
            PXY(i,j) = nosXY(i,j) / (length(Xrand));            
            if PXY(i,j) > 0
                MIXY(i,j) = PXY(i,j)*log(PXY(i,j)/max(PX(i)*PY(j),eps));                    
            end
        end
    end
%     disp(['Sum of probs is: ' num2str(sum(sum(PXY)))])
    MI = sum(sum(MIXY));
%     disp(['MI is: ' num2str(MI)]),pause;
end