% [figureHandle] = Done(BC) @ BaseClass
% just look at the code, really...
% Johannes Rebling, (johannesrebling@gmail.com), 2018

function [doneStr] = Done(BC,ticMarker)
  if nargin == 2
    doneStr = sprintf('done (%3.2f s).\n',toc(ticMarker));
  else
    doneStr = sprintf('done (%3.2f s).\n',toc());
  end
  BC.VPrintF(doneStr);
end
