% Hor_Div(BaseClass) @ BaseClass
% FSP.Hor_Div()
% same as hor_div but with directed output for fprintf
% Johannes Rebling, (johannesrebling@gmail.com), 2018

function [] = Hor_Div(BaseClass)
  if BaseClass.verboseOutput
    fprintf(BaseClass.outId,[repmat('-',1,66) '\n']);
  end
end
