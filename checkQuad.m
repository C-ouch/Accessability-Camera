function [correctQuad,counter] = checkQuad(currentPosition,desiredQuad,counter)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%disp('function run \n')
%disp(desiredQuad)
correctQuad = 0;
cordLimits = [320 240];
% Frame size: [640 480]
% mid X: 320
% mid Y: 240



switch desiredQuad

    % Check Top Left
    % Bottom right point of rectangle (5,6)

    case '1'
        if(currentPosition(5) > cordLimits(:,1) && currentPosition(6) > cordLimits(:,2))
            %move both up and right
            disp('move right and up')
            counter = 0
            
        elseif(currentPosition(5) > cordLimits(:,1))
            %move right
            disp('move right')
            counter = 0
            
        
        elseif(currentPosition(6) > cordLimits(:,2))
            %move up
            disp('move up')
            counter = 0
            

        else
            %correct quad
            disp('Correct Quad')
            counter = counter + 1
            if(counter >= 60)
                correctQuad = 1;
            end
        end
        % Check Top Right
        % Bottom Left point of rectangle (7,8)
    case '2'
        if(currentPosition(7) < cordLimits(:,1) && currentPosition(8) > cordLimits(:,2))
            %move both up and right
            disp('move left and up')
            counter = 0;
            

        elseif(currentPosition(7) < cordLimits(:,1))
            %move right
            disp('move left')
            counter = 0;
            

        elseif(currentPosition(8) > cordLimits(:,2))
            %move up
            disp('move up')
            counter = 0;
            
        else
            %correct quad
            disp('Correct Quad')
            counter = counter + 1;
            if(counter >= 60)
                correctQuad = 1;
            end
        end

        % Check Bottom Left
        % Top Right point of rectangle (3,4)
    case '3'
        if(currentPosition(1) < cordLimits(:,1) && currentPosition(2) < cordLimits(:,2))
            %move both up and right
            disp('move right and down')
            counter = 0;
            
        elseif(currentPosition(1) < cordLimits(:,1))
            %move right
            disp('move right')
            counter = 0;
            
        
        elseif(currentPosition(2) < cordLimits(:,2))
            %move up
            disp('move down')
            counter = 0;
            
        else
            %correct quad
            disp('Correct Quad')
            counter = counter + 1;
            if(counter >= 60)
                correctQuad = 1;
            end
        end

        % Check Bottom Right
        % Top Left point of rectangle (1,2)
    case '4'
        if(currentPosition(3) < cordLimits(:,1) && currentPosition(4) < cordLimits(:,2))
            %move both up and right
            disp('move left and down')
            counter = 0;
            
        elseif(currentPosition(3) < cordLimits(:,1))
            %move right
            disp('move left')
            counter = 0;
            
        elseif(currentPosition(4) < cordLimits(:,2))
            %move up
            disp('move down')
            counter = 0;
            
        else
            %correct quad
            disp('Correct Quad')
            counter = counter + 1;
            if(counter >= 60)
                correctQuad = 1;
            end

        end
    otherwise
        

end


end