function VPrintF_With_ID(Obj,varargin)
  baseStr = sprintf(varargin{:});
  Obj.VPrintF([Obj.classId ' ' baseStr]);
end
