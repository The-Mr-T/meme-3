% cubeVertex est un array de cells contenant 8 vecteur repr�sentant
% les sommets du cube {[x y z],[x y z], ... ,[x y z]}

function hasLanded = impactCubeSol(cubeVertex)

vert1 = cubeVertex{1};
vert2 = cubeVertex{2};
vert3 = cubeVertex{3};
vert4 = cubeVertex{4};
vert5 = cubeVertex{5};
vert6 = cubeVertex{6};
vert7 = cubeVertex{7};
vert8 = cubeVertex{8};

hasLanded = 0;

if vert1(3) < 0
  hasLanded = 1;
end

if vert2(3) < 0
  hasLanded = 1;
end

if vert3(3) < 0
  hasLanded = 1;
end

if vert4(3) < 0
  hasLanded = 1;
end

if vert5(3) < 0
  hasLanded = 1;
end

if vert6(3) < 0
  hasLanded = 1;
end

if vert7(3) < 0
  hasLanded = 1;
end

if vert8(3) < 0
  hasLanded = 1;
end

end

%Pretty straightfoward ;)