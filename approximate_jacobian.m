function res = approximate_jacobian(vector_fun, x0)
% Approximate Jacobian matrix based on the finite differences
% eps and delta influenced by Numerical Recipes by Press et. al
    epsilon = 1e-8; % Approximately sqrt of machine precision
    x_delta = x0;
    f0 = vector_fun(x_delta);
    res = zeros(length(f0), length(x0));
    for ii = 1:length(x0)
        temp = x_delta(ii);
        delta = epsilon * abs(temp);
        if delta <= 0.0
            delta = epsilon;
        end
        x_delta(ii) = temp + delta;
        f_delta = vector_fun(x_delta);
        res(:, ii) = (f_delta - f0) / delta; % Forward difference formula
        x_delta(ii) = temp;
    end
end
