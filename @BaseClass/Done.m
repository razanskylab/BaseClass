% [figureHandle] = Done(BC) @ BaseClass
% just look at the code, really...
% Johannes Rebling, (johannesrebling@gmail.com), 2018

function Done(BC,ticMarker)
  if nargin == 2
    BC.VPrintF('done (%3.2f s).\n',toc(ticMarker));
  else
    BC.VPrintF('done (%3.2f s).\n',toc());
  end

end
