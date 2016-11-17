

function qs = SEDRK4t0 ( q0 , w0 , Deltat , fonctiong )
    %
    % Solution ED dq / dt = fonctiong (q)
    % Methode de Runge - Kutta d' ordre 4
    % qs : vecteur final [q( tf )]
    % q0 : vecteur initial [q( ti )]
    % Deltat : intervalle de temps
    % fonctiong : membre de droite de ED .
    % Ceci est un m - file de matlab
    % qui retourne [ dq / dt ( ti )]
    %
    k1 = feval (fonctiong, q0 , w0 ) * Deltat;
    k2 = feval (fonctiong, q0 + k1 /2 , w0) * Deltat;
    k3 = feval (fonctiong, q0 + k2 /2 , w0) * Deltat;
    k4 = feval (fonctiong, q0 +k3 , w0 ) * Deltat;
    qs = q0 + (k1 + 2*k2 + 2*k3 + k4) / 6;
end