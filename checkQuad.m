function checkQuad(currentPosition,desiredQuad)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%disp('function run \n')
%disp(desiredQuad)

cordLimits = [640 360];
%disp(cordLimits(:,1))
%disp('currentpos5 \n')
%disp(currentPosition(5))
switch desiredQuad
    case '1'
        if(currentPosition(5) > cordLimits(:,1) && currentPosition(6) > cordLimits(:,2))
            %move both up and right
            disp('move right and up')
        elseif(currentPosition(5) > cordLimits(:,1))
            %move right
            disp('move right')
        
        elseif(currentPosition(6) > cordLimits(:,2))
            %move up
            disp('move up')
        else
            %correct quad
            disp('Correct Quad')
        end

    case '2'
        if(currentPosition(7) < cordLimits(:,1) && currentPosition(8) > cordLimits(:,2))
            %move both up and right
            disp('move left and up')
        elseif(currentPosition(7) < cordLimits(:,1))
            %move right
            disp('move left')
        
        elseif(currentPosition(8) > cordLimits(:,2))
            %move up
            disp('move up')
        else
            %correct quad
            disp('Correct Quad')
        end
    case '3'
        if(currentPosition(1) < cordLimits(:,1) && currentPosition(2) < cordLimits(:,2))
            %move both up and right
            disp('move right and down')
        elseif(currentPosition(1) < cordLimits(:,1))
            %move right
            disp('move right')
        
        elseif(currentPosition(2) < cordLimits(:,2))
            %move up
            disp('move down')
        else
            %correct quad
            disp('Correct Quad')
        end
    case '4'
        if(currentPosition(3) < cordLimits(:,1) && currentPosition(4) < cordLimits(:,2))
            %move both up and right
            disp('move left and down')
        elseif(currentPosition(3) < cordLimits(:,1))
            %move right
            disp('move left')
        
        elseif(currentPosition(4) < cordLimits(:,2))
            %move up
            disp('move down')
        else
            %correct quad
            disp('Correct Quad')
        end
    otherwise
        

end


end