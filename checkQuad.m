function checkQuad(currentPosition,desiredQuad)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%disp('function run \n')
%disp(desiredQuad)

cordLimits = [320 240];
% Frame size: [640 480]
% mid X: 320
% mid Y: 240


%disp(cordLimits(:,1))
%disp('currentpos5 \n')
%disp(currentPosition(5))
switch desiredQuad

    % Check Top Left
    % Bottom right point of rectangle (5,6)
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

        % Check Top Right
        % Bottom Left point of rectangle (7,8)
    case '2'
        if(currentPosition(7) < cordLimits(:,1) && currentPosition(8) > cordLimits(:,2))
            %move both up and left
            disp('move left and up')
        elseif(currentPosition(7) < cordLimits(:,1))
            %move left
            disp('move left')

        elseif(currentPosition(8) > cordLimits(:,2))
            %move up
            disp('move up')
        else
            %correct quad
            disp('Correct Quad')
        end

        % Check Bottom Left
        % Top Right point of rectangle (3,4)
    case '3'
        if(currentPosition(3) > cordLimits(:,1) && currentPosition(4) < cordLimits(:,2))
            %move both right and down
            disp('move right and down')
        elseif(currentPosition(3) > cordLimits(:,1))
            %move right
            disp('move right')

        elseif(currentPosition(4) < cordLimits(:,2))
            %move down
            disp('move down')
        else
            %correct quad
            disp('Correct Quad')
        end

        % Check Bottom Right
        % Top Left point of rectangle (1,2)
    case '4'
        if(currentPosition(1) < cordLimits(:,1) && currentPosition(2) < cordLimits(:,2))
            %move both down and left
            disp('move left and down')
        elseif(currentPosition(1) < cordLimits(:,1))
            %move right
            disp('move left')

        elseif(currentPosition(2) < cordLimits(:,2))
            %move down
            disp('move down')
        else
            %correct quad
            disp('Correct Quad')
        end
    otherwise


end


end