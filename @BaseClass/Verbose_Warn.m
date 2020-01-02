% Verbose_Warn(BaseClass) @ BaseClass
% convenience warn function
% Johannes Rebling, (johannesrebling@gmail.com), 2018

function Verbose_Warn(BaseClass,warnMessage)
  % BaseClass.Verbose_Warn(varargin)
  % plots if BaseClass.verboseOutput = true, uses BaseClass.outId
  if BaseClass.verboseOutput
    color_message(sprintf('[WARNING] %s',warnMessage));
    drawnow;
  end
end
