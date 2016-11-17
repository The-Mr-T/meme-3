% Devoir3([-2 -3 5], [0 0 0], 0.545454, [5 2 0.642424]  )
% Devoir3( [-2 -3 5], [0 0 15],0.545454 ,[5 2 0.642424])
% Devoir3( [0  -6 3 ], [0 0 0], 0.071429 ,  [7 0 0.40834]) 
% Devoir3( [0  -6 3 ],[0 0 15], 0.071429 ,[7 0 0.40834])
% Devoir3([-2 -3 5], [-5 -5 0], 0.6, [5 2 0.642424])
% Devoir3([-2 -3 5], [0 0 0], 0.1, [5 2 0.1])

% Devoir3(vbloci,avbloci,t1,vballei)
% tl (s) ~vbloc(0) (m/s) ~?bloc(0) (rad/s) ~vballe(0) (m/s)
% 0.545454 (?2, ?3, 5)T (0, 0, 0)T (5, 2, 0.642424)T
% PARAM IN
%
% vbloci  : Un vecteur de 3 éléments contenant la vitesse linéaire initiale du centre de masse du bloc.
% avbloci : Un vecteur de 3 éléments contenant la vitesse angulaire initiale du bloc autour de son centre de masse.
% vballei : Un vecteur de 3 éléments contenant la vitesse linéaire initiale du centre de masse de la balle au temps tl
% tl      : Le temps tl où le candidat a décidé de tirer la balle.

% PARAM OUT
%
% Resultat : Ici, Resultat=0 indique que la balle a touché le bloc, Resultat=-1 que la balle a touché le sol en premier et Resultat=1 que le bloc a touché le sol en premier.
% blocf    : Une matrice de 6 × 2 éléments contenant la vitesse linéaire et la vitesse angulaire du bloc tout juste avant la collision (temps t − f ) et tout juste après la collision (temps t f ).
% ballef   : Une matrice 6 × 2 contenant la vitesse linéaire et la vitesse angulaire de la balle tout juste avant la collision (temps t − f ) et tout juste après la collision (temps t f ).
% Post     : C’est une matrice contenant les points dans le temps et les positions du bloc et de la balle simulés avec

function [Resultat, blocf, ballef, Post] = Devoir3(vbloci,avbloci,t1,vballei)

% On ne prend en compte que la gravité pour les trajectoires. 
functiong = 'GFunctionOption1';

% Repr�sente la condition permettant de poursuivre la simulation. 
% 0 : La simulation peut continuer
% 1 : Le cube a touch� le sol
% 2 : La sph�re a touch� le sol
%     NB : en cas d'impact simultan�, le cube sera pris en consid�ration
%     pour l'impact. 
% 3 : Il y a eu impact entre le cube et la sph�re
simStop = 0;

% timeStep : Temps entre deux points de simulation (en secondes)
timeStep = 0.001;

% Le moment exact de la simulation. 
currentTime = 0 + timeStep; % On commence la simulation � la deuxieme etape

% Les coordonnées de la balle au début de la simulation
qBalleInit = [vballei(1) vballei(2) vballei(3) 0 0 2]; % 0 0 2 est hard coded
qBalle = qBalleInit;
% Les coordonnées du cube au début de la simulation
qCubeInit  = [vbloci(1) vbloci(2) vbloci(3) 3 3 1]; % position hard coded
qCube = qCubeInit;


%Structures de données pour les check de collision (sont modifi�es � chaque it�rations)
balle = {[0 0 2], 0.02}; % position en x y z et radius en mètres 0.02
cube = {[2.96 3.04 1.04],[3.04 3.04 1.04],[2.96 2.96 1.04],[3.04 2.96 1.04],[2.96 3.04 0.96],[3.04 3.04 0.96],[2.96 2.96 0.96],[3.04 2.96 0.96], [3 3 1]};
balleCube = {[3 3 1], sqrt(0.0048)};

Post = [0, 3 3 1, 0 0 2, 1];

iterationIndex = 2; 

while simStop == 0
    %Boucle principale de la simulation. On effectue deux calculs de
    %Runge-Kutta sur respectivement le cube et la sph�re. On d�tecte ensuite
    %les collisions � l'aide de l'algorithme rapide de d�tection de collision.
    %Si une collision est d�termin� comme possible, on effectue ensuite le
    %calcul des plans de s�paration entre les deux solides pour d�terminer si
    %il y a r�ellement collision. 

    % On utilise GFunctionOption1 du devoir pr�c�dent puisque les centres de
    % masses sont uniquement affect� par la gravit�. 

    qBalle(iterationIndex, :) = qBalleInit;
    
    % La balle n'est pas lancée à t = 0, mais à t1. 
    if currentTime > t1
       % Calcul position balle
       %qsol = [vitesseX vitesseY vitesseZ x y z];
       %res = SEDRK4t0(~qsol~, ~vitesse angulaire~, ~step de la simulation~, functiong);
       qBalle(iterationIndex, :) = SEDRK4t0(qBalle(iterationIndex - 1, :), [0 0 0] , timeStep, functiong);
    end 
  
    qCube(iterationIndex, :) = SEDRK4t0(qCube(iterationIndex - 1, :), [0 0 0] , timeStep, functiong);
    
    % on doit append � Post
    Post(iterationIndex, :) = [currentTime, [qCube(iterationIndex, 4) qCube(iterationIndex, 5) qCube(iterationIndex, 6)] , [qBalle(iterationIndex, 4) qBalle(iterationIndex, 5) qBalle(iterationIndex, 6)], iterationIndex];
    
    % On update balle et balleCube
    balle{1}(1) = qBalle(iterationIndex, 4);
    balle{1}(2) = qBalle(iterationIndex, 5);
    balle{1}(3) = qBalle(iterationIndex, 6);
    
    balleCube{1}(1) = qCube(iterationIndex, 4);
    balleCube{1}(2) = qCube(iterationIndex, 5);
    balleCube{1}(3) = qCube(iterationIndex, 6);
    
    cube{9}(1) = qCube(iterationIndex, 4);
    cube{9}(2) = qCube(iterationIndex, 5);
    cube{9}(3) = qCube(iterationIndex, 6);
    
    xAngle = avbloci(1) * currentTime; % D�placement total
    yAngle = avbloci(2) * currentTime;
    zAngle = avbloci(3) * currentTime;
    
    xRotMat = [1 0 0;0 cos(xAngle) -sin(xAngle);0 sin(xAngle) cos(xAngle)];
    yRotMat = [cos(yAngle) 0 sin(yAngle);0 1 0;-sin(yAngle) 0 cos(yAngle)];
    zRotMat = [cos(zAngle) -sin(zAngle) 0;sin(zAngle) cos(zAngle) 0;0 0 1];
    
    for i = 1:8
       % position relative du vertex vert - centre
       cube{i} = cube{i} - cube{9};
       % application de la matrice de rotation
       transp = xRotMat * yRotMat * zRotMat * cube{i}';
       cube{i} = transp';
       % position absolue
       cube{i} = cube{i} + cube{9};
    end
   
    % On doit faire un collision check (rapide)
    
    isColliding = fastCollision(balle, balleCube);
    
    % Le fast check a r�v�l� une collision
    if isColliding == 1
        disp('collision (fastcheck)')
        
        collisionData = realCheck(balle, cube, [xAngle, yAngle, zAngle])
        
        if collisionData(1) == 1
            % real check d�tecte un impact. Si ce n'est pas le cas, cela 
            % peut �tre un frolement (les sph�res se touchent pas pas le 
            % cube.)
            
            %on a les coordonn�es par rapport au centre du cube, on peut 
            % arr�ter la simulation.
            simStop = 1;
            
            collisionPoint = [collisionData(2) collisionData(3) collisionData(4)];
            normaleCollision = collisionPoint;
            normaleCollision = normaleCollision / norm(normaleCollision);
            collisionPoint = collisionPoint + cube{9}; % r�f�rentiel par rapport � l'origine
            
            inertieSphere = (2 * 0.05 / 3) * (0.02^2);
            inertieSphereMat = [inertieSphere 0 0; 0 inertieSphere 0; 0 0 inertieSphere];
            
            inertieCube = ((1 / 12) * 1.2) * ((0.08^2) * 2);
            inertieCubeMat = [inertieCube 0 0; 0 inertieCube 0; 0 0 inertieCube];
            
            %invInertieSphereMat = inv(inertieSphereMat);
            %invInertieCubeMat = inv(inertieCubeMat);
            
            RcP = cube{9} - collisionPoint;
            RbP = balle{1} - collisionPoint;
            
            
            x = balle{1}(1);
            y = balle{1}(2);
            z = balle{1}(3);
            refTRANS = [((y^2)+(z^2)), -x*y, -x*z; -y*z, ((x^2)+(z^2)), -y * z; -z * x, -z * y, ((x^2)+(y^2))];
            
            inertieSphereMatGlobale = inertieSphereMat + 0.05 * refTRANS;
            
            x = cube{9}(1);
            y = cube{9}(2);
            z = cube{9}(3);
            refTRANS = [((y^2)+(z^2)), -x*y, -x*z; -y*z, ((x^2)+(z^2)), -y * z; -z * x, -z * y, ((x^2)+(y^2))];
            
            inertieCubeMatGlobale = inertieCubeMat + 1.2 * refTRANS;
            
            a_1 = cross((cross(RbP,normaleCollision)),RbP)';
            a_2 = cross((cross(RcP,normaleCollision)),RcP)';
            
            
            Gb = dot(normaleCollision, inertieSphereMatGlobale \a_1);
            Gc = dot(normaleCollision, inertieCubeMatGlobale \a_2);
            
            a = (1 / ((1/ 1.2) + (1/0.05) + Gb + Gc));
            
            vitesseBalle = [qBalle(iterationIndex, 1) qBalle(iterationIndex, 2) qBalle(iterationIndex, 3)];
            vitesseCube = [qCube(iterationIndex, 1) qBalle(iterationIndex, 2) qBalle(iterationIndex, 3)];
            
            vrel = normaleCollision' * (vitesseBalle - vitesseCube);
            
            j = -a * (1 + 0.8) * vrel;
            
            vitesseBalleFinal = vitesseBalle' + j * ((normaleCollision' / 0.05) + (inertieSphereMatGlobale \ a_1));       
            vitesseCubeFinal = vitesseCube' - j * ((normaleCollision' / 1.2) + (inertieCubeMatGlobale \ a_2)); 
            
            tempA = inertieSphereMatGlobale \ cross(RbP,normaleCollision)'
            vitesseAngBalleFinal = j * tempA;
            
            vitesseAngCubeFinal = avbloci' - j * inertieCubeMatGlobale \ cross(RcP, normaleCollision)';
            
            blocf = [vitesseCube avbloci; vitesseCubeFinal' vitesseAngCubeFinal' ]
            ballef = [vitesseBalle 0 0 0; vitesseBalleFinal' vitesseAngBalleFinal' ]
        end
    end
    
    
    % Les vertex du cube ont �t�s mis � jour, on peut v�rifier
    % les collisions avec le sol
   
    balleHasLanded = impactBalleSol(balle);
    cubeHasLanded = impactCubeSol(cube);
    
    % Si il y a eu collision, on sort ici
    if balleHasLanded == 1
       Resultat = -1; 
       simStop = 1;
       disp('balle est atterie');
    end
    
    if cubeHasLanded == 1
        Resultat = 1;
        simStop = 1;
        disp('cube est atteris');
    end
    
    if cubeHasLanded == 1 ||  balleHasLanded == 1
        blocf = [qCube(iterationIndex, 1) qCube(iterationIndex, 2) qCube(iterationIndex, 3) avbloci;qCube(iterationIndex, 1) qCube(iterationIndex, 2) qCube(iterationIndex, 3) avbloci ]
        ballef = [qBalle(iterationIndex, 1) qBalle(iterationIndex, 2) qBalle(iterationIndex, 3) 0 0 0;qBalle(iterationIndex, 1) qBalle(iterationIndex, 2) qBalle(iterationIndex, 3) 0 0 0 ]
    end
    
    currentTime = currentTime + timeStep;
    iterationIndex = iterationIndex + 1;

    % Condition d'arr�t temporaire
    %if iterationIndex > 2000000000000000000000000 
    %    simStop = 1;
    %end

  % now we plot the whole thing
  %G�n�re le terrain
 terrain_x = linspace(0,5,5);
  terrain_y = linspace(0,5,5);
  [X,Y] = meshgrid(terrain_x,terrain_y);
  Z = X*0;
  
  mesh(X,Y,Z);
  hold on;
  plot3(Post(:,2),Post(:,3),Post(:,4),'r-');
  plot3(Post(:,5),Post(:,6),Post(:,7),'b-');
  hold on;

end

end