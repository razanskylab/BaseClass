% VPrintF(BaseClass) @ BaseClass
% convenience function to make sure we always use outId in fprintf...
% and to not have to wrap every fprintf in an if/else statement
% Johannes Rebling, (johannesrebling@gmail.com), 2018

function VPrintF(BaseClass,varargin)
  % BaseClass.VPrintF(varargin)
  % plots if BaseClass.verboseOutput = true, uses BaseClass.outId
  if BaseClass.verboseOutput
    fprintf(BaseClass.outId,varargin{:});
    drawnow;
  end
end
