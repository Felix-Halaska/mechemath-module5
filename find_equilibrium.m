function Veq = find_equilibrium(rate_fun, V0)

    [Veq, ~] = newtons_multiple(rate_fun,V0,1e-14, 1e-14, 200, 1e4, 1);
end