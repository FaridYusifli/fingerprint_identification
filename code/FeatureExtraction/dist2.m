function n2 = dist2(x, c)
[ndata, xdimention] = size(x);
[ncentres, dimcenter] = size(c);
if xdimention ~= dimcenter
	error('error')
end

n2 = (ones(ncentres, 1) * sum((x.^2)', 1))' + ...
  		ones(ndata, 1) * sum((c.^2)',1) - ...
  		2.*(x*(c'));
