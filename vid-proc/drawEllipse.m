function M = drawEllipse(a,b,z,alpha,H,W)
%Draw ellipse 
% Returns HxW binary matrix with ellipse determined by center z, axes a and
% b and rotation alpha.
% Copyright Richard Brown, this code can be freely used and modified so
% long as this line is retained


M = zeros(H,W);

    if a > 0

        npts = 10000;
        t = linspace(0, 2*pi, npts);

        % Rotation matrix
        Q = [cos(alpha), -sin(alpha); sin(alpha) cos(alpha)];
        % Ellipse points
        X = Q * [a * cos(t); b * sin(t)] + repmat(z, 1, npts);

        X = floor(X);

            for i = 1:npts
                if X(1,i) > 0 && X(1,i) < H && X(2,i) > 0 && X(2,i) < W
                M(X(1,i),X(2,i)) = 1; %Set points on ellipse edge to 1
                end
            end
    end

end
