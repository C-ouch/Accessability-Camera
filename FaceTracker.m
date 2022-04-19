% %This file tracks the users face then, calls from checkQuad to check what
% %quadrant the face is in.



% Sets up a speechClient object with the speech API and its properties.
% This currently is a female Australian voice
speechObjectGoogle = speechClient('Google','name','en-AU-Wavenet-C');
speechObjectGoogle.Options;

%ask for user input
[speech,fs] = text2speech(speechObjectGoogle,"Where would you like your face to appear ([1]top left [2]top right [3]bottom left [4]bottom right)");
sound(speech,fs)

pause(5);

% Use microphone to record audio
recObj = audiorecorder(44100, 16, 1);
disp('Start speaking.')
recordblocking(recObj, 5);
disp('End of Recording.')

y = getaudiodata(recObj);

%Takes recorded audio and passes it to Google speech2text api and outputs
%desired quadrant
speechObject = speechClient('Google','languageCode','en-US');
tableOut = speech2text(speechObject,y,44100);
desiredQuad = tableOut;


%This file tracks the users face then, calls from checkQuad to check what
%quadrant the face is in.

% %ask for user input
% desiredQuad = input("Where would you like your face to appear ([1]top left [2]top right [3]bottom left [4]bottom right)","s");

% Sets up a speechClient object with the speech API and its properties.
% This currently is a female Australian voice
speechObjectGoogle = speechClient('Google','name','en-AU-Wavenet-C');
speechObjectGoogle.Options;

% Create the face detector object.
faceDetector = vision.CascadeObjectDetector();

% Create the point tracker object.
pointTracker = vision.PointTracker('MaxBidirectionalError', 2);

% Create the webcam object.
cam = webcam();

% Capture one frame to get its size.
videoFrame = snapshot(cam);
frameSize = size(videoFrame);

% Create the video player object.
videoPlayer = vision.VideoPlayer('Position', [100 100 [frameSize(2), frameSize(1)]+30]);

runLoop = true;
numPts = 0;
frameCount = 0;
framesInCorrectQuad = 0;

% Sets an initial previous intruction so the checkQuad can run
prev_instruction = "";

%Starts out with thinking there is no face found
found = 1;

while runLoop && frameCount < 800

    % Get the next frame.
    videoFrame = snapshot(cam);
    videoFrameGray = rgb2gray(videoFrame);
    frameCount = frameCount + 1;

    if numPts < 10
        % Detection mode.
        bbox = faceDetector.step(videoFrameGray);

        if ~isempty(bbox)
            % Find corner points inside the detected region.
            points = detectMinEigenFeatures(videoFrameGray, 'ROI', bbox(1, :));

            % Re-initialize the point tracker.
            xyPoints = points.Location;
            numPts = size(xyPoints,1);
            release(pointTracker);
            initialize(pointTracker, xyPoints, videoFrameGray);

            % Save a copy of the points.
            oldPoints = xyPoints;

            % Convert the rectangle represented as [x, y, w, h] into an
            % M-by-2 matrix of [x,y] coordinates of the four corners. This
            % is needed to be able to transform the bounding box to display
            % the orientation of the face.
            bboxPoints = bbox2points(bbox(1, :));

            % Convert the box corners into the [x1 y1 x2 y2 x3 y3 x4 y4]
            % format required by insertShape.
            bboxPolygon = reshape(bboxPoints', 1, []);

            % Display a bounding box around the detected face.
            videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygon, 'LineWidth', 3);

            % Display detected corners.
            videoFrame = insertMarker(videoFrame, xyPoints, '+', 'Color', 'white');
            
            % if face is found: found = true
            found = 1;
            [speech,fs] = text2speech(speechObjectGoogle,"Face Found");
            sound(speech,fs)
        else
            % if face is not found: found = 0
            if(found == 1)
                found = false;
                [speech,fs] = text2speech(speechObjectGoogle,"Face not Found, try slowly moving to the left");
                sound(speech,fs)
                lastFrameNF = frameCount;
            
            elseif(lastFrameNF == frameCount - 90 && found == 0)
                [speech,fs] = text2speech(speechObjectGoogle,"Face still not Found, slowly move right");
                sound(speech,fs)

            elseif(lastFrameNF == frameCount - 60 && found == 2)
                [speech,fs] = text2speech(speechObjectGoogle,"Face still Lost, try slowly moving in the opposite direction");
                sound(speech,fs)
            end
        end

    else
        % Tracking mode.
        [xyPoints, isFound] = step(pointTracker, videoFrameGray);
        visiblePoints = xyPoints(isFound, :);
        oldInliers = oldPoints(isFound, :);

        numPts = size(visiblePoints, 1);

        if numPts >= 10
            % Estimate the geometric transformation between the old points
            % and the new points.
            [xform, inlierIdx] = estimateGeometricTransform2D(...
                oldInliers, visiblePoints, 'similarity', 'MaxDistance', 4);
            oldInliers    = oldInliers(inlierIdx, :);
            visiblePoints = visiblePoints(inlierIdx, :);

            % Apply the transformation to the bounding box.
            bboxPoints = transformPointsForward(xform, bboxPoints);

            % Convert the box corners into the [x1 y1 x2 y2 x3 y3 x4 y4]
            % format required by insertShape.
            bboxPolygon = reshape(bboxPoints', 1, []);

            %run function that uses [x1 y1 x2 y2 ...] to see if the person
            %is in frame and if not it will tell the user what direction to
            %move.
            % frameCount is an argument so the text-to-speech doesn't go
            %off every frame.
            
            [prev_instruction, takePicture,framesInCorrectQuad] = checkQuad(bboxPolygon,desiredQuad.(1), prev_instruction, framesInCorrectQuad);


            if(takePicture == 1)
                img = snapshot(cam);
                image(img);
                imwrite(img,'SelfPhoto.JPEG','Quality', 100);
                [speech,fs] = text2speech(speechObjectGoogle,"Picture Taken");
                sound(speech,fs)
                break;
            end

            % Display a bounding box around the face being tracked.
            videoFrame = insertShape(videoFrame, 'Polygon', bboxPolygon, 'LineWidth', 3);

            % Display tracked points.
            videoFrame = insertMarker(videoFrame, visiblePoints, '+', 'Color', 'white');

            % Reset the points.
            oldPoints = visiblePoints;
            setPoints(pointTracker, oldPoints);

        else
            % if face is lost: found = 2
            [speech,fs] = text2speech(speechObjectGoogle,"Face Lost, stay still");
            sound(speech,fs)
            found = 2;
            lastFrameNF = frameCount;
        end

    end

    % Display the annotated video frame using the video player object.
    step(videoPlayer, videoFrame);

    % Check whether the video player window has been closed.
    runLoop = isOpen(videoPlayer);
end

% Clean up.
clear cam;
release(videoPlayer);
release(pointTracker);
release(faceDetector);