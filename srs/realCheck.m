% Impact == 1 si il y a une collision
% 0 sinon. 

% rotVector représente la rotation sur chaque axe pour le cube. 
% realCheck({[30 30 30], 9},{[0 1 1],[1 1 1],[1 0 1],[0 0 1],[0 1 0],[1 1 0],[1 0 0],[0 0 0],[0.5 0.5 0.5]},[1 1 1])

function retVal = realCheck( sphere, cube, rotVector )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    impact = 0;
    %disp('before');
    %cube{1} - cube{9}
    %cube{2} - cube{9}
    %cube{3} - cube{9}
    %cube{4} - cube{9}

    xAngle = -rotVector(1); % On fait la rotation inverse
    yAngle = -rotVector(2);
    zAngle = -rotVector(3);
    
    xRotMat = [1 0 0;0 cos(xAngle) -sin(xAngle);0 sin(xAngle) cos(xAngle)];
    yRotMat = [cos(yAngle) 0 sin(yAngle);0 1 0;-sin(yAngle) 0 cos(yAngle)];
    zRotMat = [cos(zAngle) -sin(zAngle) 0;sin(zAngle) cos(zAngle) 0;0 0 1];
    
    for i = 1:8
       % position relative du vertex vert - centre
       cube{i} = cube{i} - cube{9}; % Référenciel du centre de masse du cube
       % application de la matrice de rotation
       transp = xRotMat * yRotMat * zRotMat * cube{i}';
       cube{i} = transp';
       % position absolue
       %cube{i} = cube{i} + cube{9};
       

    end
    
    sphere{1} = sphere{1} - cube{9}; % Référenciel du centre de masse du cube
    transpS = xRotMat * yRotMat * zRotMat * sphere{1}';
    sphere{1} = transpS';
    sphere{1}
    
    %disp('after');
    %cube{1}
    %cube{2}
    %cube{3}
    %cube{4}
    
    % "Projection" sur 3 plans
    
    % x-y
    % axe des x
    % vertex 3 et 4, composante en x
    impactAxeX = 0;
    intersecX = 0;
    proj = [cube{3}(1), cube{4}(1)];
    sproj = sphere{1}(1)
    maxProj = max(proj)
    minProj = min(proj)
    
    % intersection dans l'axe des x
    if((sproj + sphere{2} > -0.04) && (sproj + sphere{2} < 0.04))
        intersecX = 1;
        impactAxeX = sproj + sphere{2};
    end
    
    if ((sproj - sphere{2} > -0.04) && (sproj - sphere{2} < 0.04))
        intersecX = 1;
        impactAxeX = sproj - sphere{2};
    end
    
    if((sproj > -0.04) && (sproj < 0.04))
        intersecX = 1;
        impactAxeX = sproj;
    end
    
    % axe des y
    % vertex 4 et 1, composante en y
    impactAxeY = 0;
    intersecY = 0;
    proj = [cube{4}(2), cube{1}(2)];
    sproj = sphere{1}(2);
    maxProj = max(proj);
    minProj = min(proj);
    
    % intersection dans l'axe des y
    if((sproj + sphere{2} > -0.04) && (sproj + sphere{2} < 0.04))
        intersecY = 1;
        impactAxeY = sproj + sphere{2};
    end
    
    if ((sproj - sphere{2} > -0.04) && (sproj - sphere{2} < 0.04))
        intersecY = 1;
        impactAxeY = sproj - sphere{2};
    end
    
    if((sproj > -0.04) && (sproj < 0.04))
        intersecY = 1;
        impactAxeY = sproj;
    end
    
    % z-x
    % axe des z
    % vertex 4 et 8, composante en z
    impactAxeZ = 0;
    intersecZ = 0;
    proj = [cube{4}(3), cube{8}(3)];
    sproj = sphere{1}(3);
    maxProj = max(proj);
    minProj = min(proj);
    
    % intersection dans l'axe des y
    if((sproj + sphere{2} > -0.04) && (sproj + sphere{2} < 0.04))
        intersecZ = 1;
        impactAxeZ = sproj + sphere{2};
    end
    
    if ((sproj - sphere{2} > -0.04) && (sproj - sphere{2} < 0.04))
        intersecZ = 1;
        impactAxeZ = sproj - sphere{2};
    end
    
    if((sproj > -0.04) && (sproj < 0.04))
        intersecZ = 1;
        impactAxeZ = sproj;
    end
    
    
    % ici on vérifie si on a eu une collision dans les 2 axes
    
    coordX = impactAxeX;
    coordY = impactAxeY;
    coordZ = impactAxeZ;
    
    impactVec = [coordX coordY coordZ];
    
    xAngle = rotVector(1); % On fait la rotation
    yAngle = rotVector(2);
    zAngle = rotVector(3);
    
    xRotMat = [1 0 0;0 cos(xAngle) -sin(xAngle);0 sin(xAngle) cos(xAngle)];
    yRotMat = [cos(yAngle) 0 sin(yAngle);0 1 0;-sin(yAngle) 0 cos(yAngle)];
    zRotMat = [cos(zAngle) -sin(zAngle) 0;sin(zAngle) cos(zAngle) 0;0 0 1];
    
    
    impactVecRot = xRotMat * yRotMat * zRotMat * impactVec';
    impactVecRot = impactVecRot';
    %On doit faire la rotation inverse pour retrouver le systeme de 
    %coordonnées originelles    
    
    
    if (intersecX == 1 && intersecY == 1 && intersecZ == 1)
        disp('foo');
        impact = 1;
        coordX = impactVecRot(1)
        coordY = impactVecRot(2)
        coordZ = impactVecRot(3)
        retVal = [impact coordX coordY coordZ];
    else
        retVal = [impact 0 0 0];
    end
    
end