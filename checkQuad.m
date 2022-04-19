function [return_prev] = checkQuad(currentPosition,desiredQuad, prev_instruction)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%disp('function run \n')
%disp(desiredQuad)

% Frame size: [640 480]
% mid X: 320
% mid Y: 240
cordLimits = [320 240];

% currentPosition is (x1,y1), (x2,y2), (x3,y3), (x4,y4), but in an array so
% currentPosition = [1,2, 3,4, 5,6, 7,8]

% Sets up a speechClient object with the speech API and its properties.
% This currently is a female Australian voice
speechObjectGoogle = speechClient('Google','name','en-AU-Wavenet-C');
speechObjectGoogle.Options;



switch desiredQuad

    % Check Top Left
    % Bottom right point of rectangle (5,6)
    case '1'
        if(currentPosition(5) > cordLimits(:,1) && currentPosition(6) > cordLimits(:,2))
            %move both up and right
            text = "move right and up";
            return_prev = text;

        elseif(currentPosition(5) > cordLimits(:,1))
            %move right
            text = "move right";
            return_prev = text;

        elseif(currentPosition(6) > cordLimits(:,2))
            %move up
            text = "move up";
            return_prev = text;

        else
            %correct quad
            text = "Correct Quadrant";
            return_prev = text;
        end

        % Check Top Right
        % Bottom Left point of rectangle (7,8)
    case '2'
        if(currentPosition(7) < cordLimits(:,1) && currentPosition(8) > cordLimits(:,2))
            %move both up and left
            text = "move left and up";
            return_prev = text;

        elseif(currentPosition(7) < cordLimits(:,1))
            %move left
            text = "move left";
            return_prev = text;

        elseif(currentPosition(8) > cordLimits(:,2))
            %move up
            text = "move up";
            return_prev = text;
        else
            %correct quad
            text = "Correct Quadrant";
            return_prev = text;
        end

        % Check Bottom Left
        % Top Right point of rectangle (3,4)
    case '3'
        if(currentPosition(3) > cordLimits(:,1) && currentPosition(4) < cordLimits(:,2))
            %move both right and down            
            text = "move right and down";
            return_prev = text;

        elseif(currentPosition(3) > cordLimits(:,1))
            %move right
            text = "move right";
            return_prev = text;

        elseif(currentPosition(4) < cordLimits(:,2))
            %move down
            text = "move down";
            return_prev = text;
        else
            %correct quad
            text = "Correct Quadrant";
            return_prev = text;
        end

        % Check Bottom Right
        % Top Left point of rectangle (1,2)
    case '4'
        if(currentPosition(1) < cordLimits(:,1) && currentPosition(2) < cordLimits(:,2))
            %move both left and down            
            text = "move left and down";
            return_prev = text;

        elseif(currentPosition(1) < cordLimits(:,1))
            %move left
            text = "move left";
            return_prev = text;

        elseif(currentPosition(2) < cordLimits(:,2))
            %move down
            text = "move down";
            return_prev = text;
        else
            %correct quad
            text = "Correct Quadrant";
            return_prev = text;
        end
    otherwise
end

%This makes it so the voice doesn't repeat everytime it calls the function
if(text ~= prev_instruction)
    [speech,fs] = text2speech(speechObjectGoogle,text);
    sound(speech,fs)
end

end