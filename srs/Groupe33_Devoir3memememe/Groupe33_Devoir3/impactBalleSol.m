% impactBalleSol
% hasLanded = 0 si la balle ne touche pas le sol
% hasLanded = 1 si la balle touche le sol
%
% Le sol est définit comme étant z == 0
%
% La balle est un array de cell, {[x,y,z], radius}

function hasLanded = impactBalleSol(balle)

hasLanded = 0;

posVec = balle{1};

if (posVec(3) - balle{2}) < 0.001
    %le rebord de la balle est à moins de 1 mm
    %du sol
    hasLanded = 1;
end
end