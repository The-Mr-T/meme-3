% fastCollision
%
% Cheap and imprecise method used to rule out collisions 
% when the objects are far away from eachother. 
%
% solid 1 and 2 must be an array of two elements
%       First  : A vector of [x, y, z]
%       Second : radius of collision sphere
% 
% Returns 1 when there is a collision, 0 otherwise
function isColliding = fastCollision(solid1, solid2)

isColliding = 0;

distVec = solid1{1} - solid2{1};

% norm : computes the euclidian distance
dist = norm(distVec);

if dist < (solid1{2} + solid2{2})
    isColliding = 1;
end

end